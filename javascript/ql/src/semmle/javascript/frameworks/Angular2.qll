/**
 * Provides classes for working with Angular (also known as Angular 2.x) applications.
 */

private import javascript
private import semmle.javascript.security.dataflow.Xss
private import semmle.javascript.security.dataflow.CodeInjectionCustomizations
private import semmle.javascript.security.dataflow.ClientSideUrlRedirectCustomizations
private import semmle.javascript.DynamicPropertyAccess
private import semmle.javascript.dataflow.internal.PreCallGraphStep

/**
 * Provides classes for working with Angular (also known as Angular 2.x) applications.
 */
module Angular2 {
  /** Gets a reference to a `Router` object. */
  DataFlow::SourceNode router() { result.hasUnderlyingType("@angular/router", "Router") }

  /** Gets a reference to a `RouterState` object. */
  DataFlow::SourceNode routerState() {
    result.hasUnderlyingType("@angular/router", "RouterState")
    or
    result = router().getAPropertyRead("routerState")
  }

  /** Gets a reference to a `RouterStateSnapshot` object. */
  DataFlow::SourceNode routerStateSnapshot() {
    result.hasUnderlyingType("@angular/router", "RouterStateSnapshot")
    or
    result = routerState().getAPropertyRead("snapshot")
  }

  /** Gets a reference to an `ActivatedRoute` object. */
  DataFlow::SourceNode activatedRoute() {
    result.hasUnderlyingType("@angular/router", "ActivatedRoute")
  }

  /** Gets a reference to an `ActivatedRouteSnapshot` object. */
  DataFlow::SourceNode activatedRouteSnapshot() {
    result.hasUnderlyingType("@angular/router", "ActivatedRouteSnapshot")
    or
    result = activatedRoute().getAPropertyRead("snapshot")
  }

  /**
   * Gets a data flow node referring to the value of the route property `name`, accessed
   * via one of the following patterns:
   * ```js
   * route.snapshot.name
   * route.snapshot.data.name
   * route.name.subscribe(x => ...)
   * ```
   */
  DataFlow::SourceNode activatedRouteProp(string name) {
    // this.route.snapshot.foo
    result = activatedRouteSnapshot().getAPropertyRead(name)
    or
    // this.route.snapshot.data.foo
    result = activatedRouteSnapshot().getAPropertyRead("data").getAPropertyRead(name)
    or
    // this.route.foo.subscribe(foo => { ... })
    result =
      activatedRoute()
          .getAPropertyRead(name)
          .getAMethodCall("subscribe")
          .getABoundCallbackParameter(0, 0)
  }

  /** Gets an array of URL segments matched by some route. */
  private DataFlow::SourceNode urlSegmentArray() { result = activatedRouteProp("url") }

  /** Gets a data flow node referring to a `UrlSegment` object matched by some route. */
  DataFlow::SourceNode urlSegment() {
    result = getAnEnumeratedArrayElement(urlSegmentArray())
    or
    result = urlSegmentArray().getAPropertyRead(any(string s | exists(s.toInt())))
  }

  /** Gets a reference to a `ParamMap` object, usually containing values from the URL. */
  DataFlow::SourceNode paramMap() {
    result.hasUnderlyingType("@angular/router", "ParamMap")
    or
    result = activatedRouteProp(["paramMap", "queryParamMap"])
    or
    result = urlSegment().getAPropertyRead("parameterMap")
  }

  /** Gets a reference to a `Params` object, usually containing values from the URL. */
  DataFlow::SourceNode paramDictionaryObject() {
    result.hasUnderlyingType("@angular/router", "Params") and
    not result instanceof DataFlow::ObjectLiteralNode // ignore object literals found by contextual typing
    or
    result = activatedRouteProp(["params", "queryParams"])
    or
    result = paramMap().getAPropertyRead("params")
    or
    result = urlSegment().getAPropertyRead("parameters")
  }

  /**
   * A value from `@angular/router` derived from the URL.
   */
  class AngularSource extends RemoteFlowSource {
    AngularSource() {
      this = paramMap().getAMethodCall(["get", "getAll"])
      or
      this = paramDictionaryObject()
      or
      this = activatedRouteProp("fragment")
      or
      this = urlSegment().getAPropertyRead("path")
      or
      // Note that Router.url and RouterStateSnapshot.url are strings, not UrlSegment[]
      this = router().getAPropertyRead("url")
      or
      this = routerStateSnapshot().getAPropertyRead("url")
    }

    override string getSourceType() { result = "Angular route parameter" }
  }

  /** Gets a reference to a `DomSanitizer` object. */
  DataFlow::SourceNode domSanitizer() {
    result.hasUnderlyingType("@angular/platform-browser", "DomSanitizer")
  }

  /** A value that is about to be promoted to a trusted HTML or CSS value. */
  private class AngularXssSink extends DomBasedXss::Sink {
    AngularXssSink() {
      this =
        domSanitizer()
            .getAMethodCall(["bypassSecurityTrustHtml", "bypassSecurityTrustStyle"])
            .getArgument(0)
    }
  }

  /** A value that is about to be promoted to a trusted script value. */
  private class AngularCodeInjectionSink extends CodeInjection::Sink {
    AngularCodeInjectionSink() {
      this = domSanitizer().getAMethodCall(["bypassSecurityTrustScript"]).getArgument(0)
    }
  }

  /**
   * A value that is about to be promoted to a trusted URL or resource URL value.
   */
  private class AngularUrlSink extends ClientSideUrlRedirect::Sink {
    // We mark this as a client URL redirect sink for precision reasons, though its description can be a bit confusing.
    AngularUrlSink() {
      this =
        domSanitizer()
            .getAMethodCall(["bypassSecurityTrustUrl", "bypassSecurityTrustResourceUrl"])
            .getArgument(0)
    }
  }

  private predicate taintStep(DataFlow::Node pred, DataFlow::Node succ) {
    exists(DataFlow::CallNode call |
      call = DataFlow::moduleMember("@angular/router", "convertToParamMap").getACall()
      or
      call = router().getAMemberCall(["parseUrl", "serializeUrl"])
    |
      pred = call.getArgument(0) and
      succ = call
    )
  }

  private class AngularTaintStep extends TaintTracking::AdditionalTaintStep {
    AngularTaintStep() { taintStep(_, this) }

    override predicate step(DataFlow::Node pred, DataFlow::Node succ) { taintStep(pred, succ) }
  }

  /** Gets a reference to an `HttpClient` object. */
  DataFlow::SourceNode httpClient() {
    result.hasUnderlyingType("@angular/common/http", "HttpClient")
  }

  private class AngularClientRequest extends ClientRequest::Range, DataFlow::MethodCallNode {
    int argumentOffset;

    AngularClientRequest() {
      this = httpClient().getAMethodCall("request") and argumentOffset = 1
      or
      this = httpClient().getAMethodCall() and
      not getMethodName() = "request" and
      argumentOffset = 0
    }

    override DataFlow::Node getUrl() { result = getArgument(argumentOffset) }

    override DataFlow::Node getHost() { none() }

    override DataFlow::Node getADataNode() {
      getMethodName() = ["patch", "post", "put"] and
      result = getArgument(argumentOffset + 1)
      or
      result = getOptionArgument(argumentOffset + 1, "body")
    }
  }

  private string getInternalName(string name) {
    exists(Identifier id |
      result = id.getName() and
      name = result.regexpCapture("\\u0275(DomAdapter|getDOM)", 1)
    )
  }

  /** Gets a reference to a `DomAdapter`, which provides acess to raw DOM elements. */
  private DataFlow::SourceNode domAdapter() {
    // Note: these are internal properties, prefixed with the "latin small letter barred O (U+0275)" character.
    // Despite being internal, some codebases do access them.
    result.hasUnderlyingType("@angular/common", getInternalName("DomAdapter"))
    or
    result = DataFlow::moduleImport("@angular/common").getAMemberCall(getInternalName("getDOM"))
  }

  /** A reference to the DOM location obtained through `DomAdapter.getLocation()`. */
  private class DomAdapterLocation extends DOM::LocationSource::Range {
    DomAdapterLocation() { this = domAdapter().getAMethodCall("getLocation") }
  }

  /**
   * A reference to a pipe function, occurring in an Angular pipe expression
   * that has been desugared to a function call.
   *
   * For example, the expression `x | f: y` is desugared to `f(x, y)` where
   * `f` is a `PipeRefExpr`.
   */
  class PipeRefExpr extends Expr, @angular_pipe_ref {
    /** Gets the identifier node naming the pipe. */
    Identifier getIdentifier() {
      result = getChildExpr(0)
    }

    /** Gets the name of the pipe being referenced. */
    string getName() { result = getIdentifier().getName() }

    override string getAPrimaryQlClass() {
      result = "Angular2::PipeRefExpr"
    }
  }

  /** The RHS of a `templateUrl` property, seen as a path expression. */
  private class TemplateUrlPath extends PathExpr {
    TemplateUrlPath() {
      exists(Property prop |
        prop.getName() = "templateUrl" and
        this = prop.getInit()
      )
    }

    override string getValue() {
      result = this.(Expr).getStringValue()
    }
  }

  /**
   * Holds if the value of `attrib` is interpreted as an Angular expression.
   */
  predicate isAngularExpressionAttribute(HTML::Attribute attrib) {
    attrib.getName().matches("(%)") or
    attrib.getName().matches("[%]") or
    attrib.getName().matches("*ng%")
  }

  /**
   * Gets a global variable access to `name` within the given attribute.
   */
  pragma[noinline]
  private GlobalVarAccess getAGlobalVarAccessInAttribute(CodeInAttribute code, string name) {
    exists(ComponentClass cls) and // do not materialize for non-Angular codebases
    result.getTopLevel() = code and
    result.getName() = name
  }

  /**
   * The class for an Angular component.
   */
  class ComponentClass extends DataFlow::ClassNode {
    DataFlow::CallNode decorator;

    ComponentClass() {
      decorator = getADecorator() and
      decorator = DataFlow::moduleMember("@angular/core", "Component").getACall()
    }

    /**
     * Gets a data flow node representing the value of the declared
     * instance field of the given name.
     */
    DataFlow::Node getFieldNode(string name) {
      exists(FieldDeclaration f |
        f.getName() = name and
        f.getDeclaringClass().flow() = this and
        result = DataFlow::fieldDeclarationNode(f)
      )
    }

    /**
     * Gets a data flow node representing data flowing into a field of
     * this component.
     */
    DataFlow::Node getFieldInputNode(string name) {
      result = getFieldNode(name)
      or
      result = getInstanceMember(name, DataFlow::MemberKind::setter()).getParameter(0)
    }

    /**
     * Gets a data flow node representing data flowing out of a field
     * of this component.
     */
    DataFlow::Node getFieldOutputNode(string name) {
      result = getFieldNode(name)
      or
      result = getInstanceMember(name, DataFlow::MemberKind::getter()).getReturnNode()
      or
      result = getInstanceMethod(name)
    }

    /**
     * Gets the `selector` property of the `@Component` decorator.
     */
    string getSelector() {
      decorator.getOptionArgument(0, "selector").mayHaveStringValue(result)
    }

    /** Gets an HTML element that instantiates this component. */
    HTML::Element getATemplateInstantiation() {
      result.getName() = getSelector()
    }

    /** Gets an argument that flows into the `name` field of this component. */
    DataFlow::Node getATemplateArgument(string name) {
      result = getATemplateInstantiation().getAttributeByName("[" + name + "]").getCodeInAttribute().getChildStmt(0).(ExprStmt).getExpr().flow()
    }

    /** Gets the `templateUrl` property of the `@Component` decorator. */
    string getTemplateUrl() {
      decorator.getOptionArgument(0, "templateUrl").mayHaveStringValue(result)
    }

    /**
     * Gets the file referred to by `templateUrl`.
     *
     * Has no result if the template is given inline via a `template` property.
     */
    pragma[noinline]
    File getTemplateFile() {
      result = decorator.getOptionArgument(0, "templateUrl").asExpr().(PathExpr).resolve()
    }

    /**
     * Gets an access to the variable `name` in the template body.
     */
    DataFlow::Node getATemplateVarAccess(string name) {
      exists(HTML::Attribute attrib |
        attrib.getFile() = getTemplateFile() and
        isAngularExpressionAttribute(attrib) and
        result = getAGlobalVarAccessInAttribute(attrib.getCodeInAttribute(), name).flow()
      )
    }
  }

  private class ComponentSteps extends PreCallGraphStep {
    override predicate step(DataFlow::Node pred, DataFlow::Node succ) {
      exists(ComponentClass cls, string name |
        // From <my-class [foo]="bar"/> to `foo` field in class
        pred = cls.getATemplateArgument(name) and
        succ = cls.getFieldInputNode(name)
        or
        // From `foo` field in class to <other-component [baz]="foo"/>
        pred = cls.getFieldOutputNode(name) and
        succ = cls.getATemplateVarAccess(name)
        or
        // From property write to the field input node
        pred = cls.getAReceiverNode().getAPropertyWrite(name).getRhs() and
        succ = cls.getFieldInputNode(name)
        or
        // From the field node to property read.
        // We use `getFieldNode` instead of `getFieldOutputNode` as the other two cases
        // from `getFieldOutputNode` are already handled by the general data flow library.
        pred = cls.getFieldNode(name) and
        succ = cls.getAReceiverNode().getAPropertyRead(name)
      )
    }
  }
}
