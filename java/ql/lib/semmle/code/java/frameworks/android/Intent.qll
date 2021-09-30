import java
private import semmle.code.java.dataflow.DataFlow
import semmle.code.java.dataflow.FlowSteps
import semmle.code.java.dataflow.ExternalFlow

/**
 * The class `android.content.Intent`.
 */
class TypeIntent extends Class {
  TypeIntent() { this.hasQualifiedName("android.content", "Intent") }
}

/** The class `android.content.ComponentName`. */
class TypeComponentName extends Class {
  TypeComponentName() { this.hasQualifiedName("android.content", "ComponentName") }
}

/**
 * The class `android.app.Activity`.
 */
class TypeActivity extends Class {
  TypeActivity() { this.hasQualifiedName("android.app", "Activity") }
}

/**
 * The class `android.content.Context`.
 */
class TypeContext extends RefType {
  TypeContext() { this.hasQualifiedName("android.content", "Context") }
}

/**
 * The class `android.content.BroadcastReceiver`.
 */
class TypeBroadcastReceiver extends Class {
  TypeBroadcastReceiver() { this.hasQualifiedName("android.content", "BroadcastReceiver") }
}

/**
 * The method `Activity.getIntent`
 */
class AndroidGetIntentMethod extends Method {
  AndroidGetIntentMethod() {
    this.hasName("getIntent") and this.getDeclaringType() instanceof TypeActivity
  }
}

/**
 * The method `BroadcastReceiver.onReceive`.
 */
class AndroidReceiveIntentMethod extends Method {
  AndroidReceiveIntentMethod() {
    this.hasName("onReceive") and this.getDeclaringType() instanceof TypeBroadcastReceiver
  }
}

/**
 * The method `Context.startActivity` or `startActivities`.
 */
class ContextStartActivityMethod extends Method {
  ContextStartActivityMethod() {
    (this.hasName("startActivity") or this.hasName("startActivities")) and
    this.getDeclaringType() instanceof TypeContext
  }
}

/**
 * Specifies that if an `Intent` is tainted, then so are its synthetic fields.
 */
private class IntentFieldsInheritTaint extends DataFlow::SyntheticFieldContent,
  TaintInheritingContent {
  IntentFieldsInheritTaint() { this.getField().matches("android.content.Intent.%") }
}

/**
 * The method `Intent.getParcelableExtra`.
 */
class IntentGetParcelableExtraMethod extends Method {
  IntentGetParcelableExtraMethod() {
    this.hasName("getParcelableExtra") and
    this.getDeclaringType() instanceof TypeIntent
  }
}

/** The class `android.os.BaseBundle`, or a class that extends it. */
class AndroidBundle extends Class {
  AndroidBundle() { this.getASupertype*().hasQualifiedName("android.os", "BaseBundle") }
}

/** The class `android.app.PendingIntent`. */
class PendingIntent extends Class {
  PendingIntent() { this.hasQualifiedName("android.app", "PendingIntent") }
}

/** An `Intent` that explicitly sets a destination component. */
class ExplicitIntent extends Expr {
  ExplicitIntent() {
    exists(MethodAccess ma, Method m |
      ma.getMethod() = m and
      m.getDeclaringType() instanceof TypeIntent and
      m.hasName(["setPackage", "setClass", "setClassName", "setComponent"]) and
      ma.getQualifier() = this
    )
    or
    exists(ConstructorCall cc, Argument classArg |
      cc.getConstructedType() instanceof TypeIntent and
      cc.getAnArgument() = classArg and
      classArg.getType() instanceof TypeClass and
      not exists(NullLiteral nullLiteral | DataFlow::localExprFlow(nullLiteral, classArg)) and
      cc = this
    )
  }
}

/**
 * A sanitizer for explicit intents.
 *
 * Use this when you want to work only with implicit intents
 * in a `DataFlow` or `TaintTracking` configuration.
 */
class ExplicitIntentSanitizer extends DataFlow::Node {
  ExplicitIntentSanitizer() {
    exists(ExplicitIntent explIntent | DataFlow::localExprFlow(explIntent, this.asExpr()))
  }
}

private class BundleExtrasSyntheticField extends SyntheticField {
  BundleExtrasSyntheticField() { this = "android.content.Intent.extras" }

  override RefType getType() { result instanceof AndroidBundle }
}

/**
 * Holds if extras may be implicitly read from the Intent `node`.
 */
predicate allowIntentExtrasImplicitRead(DataFlow::Node node, DataFlow::Content c) {
  node.getType() instanceof TypeIntent and
  (
    c instanceof DataFlow::MapValueContent
    or
    c.(DataFlow::SyntheticFieldContent).getType() instanceof AndroidBundle
  )
}

private class IntentBundleFlowSteps extends SummaryModelCsv {
  override predicate row(string row) {
    row =
      [
        //"namespace;type;subtypes;name;signature;ext;input;output;kind"
        "android.os;BaseBundle;true;get;(String);;MapValue of Argument[-1];ReturnValue;value",
        "android.os;BaseBundle;true;getString;(String);;MapValue of Argument[-1];ReturnValue;value",
        "android.os;BaseBundle;true;getString;(String,String);;MapValue of Argument[-1];ReturnValue;value",
        "android.os;BaseBundle;true;getString;(String,String);;Argument[1];ReturnValue;value",
        "android.os;BaseBundle;true;getStringArray;(String);;MapValue of Argument[-1];ReturnValue;value",
        "android.os;BaseBundle;true;keySet;();;MapKey of Argument[-1];Element of ReturnValue;value",
        "android.os;BaseBundle;true;putAll;(PersistableBundle);;MapKey of Argument[0];MapKey of Argument[-1];value",
        "android.os;BaseBundle;true;putAll;(PersistableBundle);;MapValue of Argument[0];MapValue of Argument[-1];value",
        "android.os;BaseBundle;true;putBoolean;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;BaseBundle;true;putBooleanArray;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;BaseBundle;true;putDouble;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;BaseBundle;true;putDoubleArray;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;BaseBundle;true;putInt;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;BaseBundle;true;putIntArray;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;BaseBundle;true;putLong;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;BaseBundle;true;putLongArray;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;BaseBundle;true;putString;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;BaseBundle;true;putString;;;Argument[1];MapValue of Argument[-1];value",
        "android.os;BaseBundle;true;putStringArray;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;BaseBundle;true;putStringArray;;;Argument[1];MapValue of Argument[-1];value",
        "android.os;Bundle;false;Bundle;(Bundle);;MapKey of Argument[0];MapKey of Argument[-1];value",
        "android.os;Bundle;false;Bundle;(Bundle);;MapValue of Argument[0];MapValue of Argument[-1];value",
        "android.os;Bundle;false;Bundle;(PersistableBundle);;MapKey of Argument[0];MapKey of Argument[-1];value",
        "android.os;Bundle;false;Bundle;(PersistableBundle);;MapValue of Argument[0];MapValue of Argument[-1];value",
        "android.os;Bundle;true;clone;();;MapKey of Argument[-1];MapKey of ReturnValue;value",
        "android.os;Bundle;true;clone;();;MapValue of Argument[-1];MapValue of ReturnValue;value",
        // model for Bundle.deepCopy is not fully precise, as some map values aren't copied by value
        "android.os;Bundle;true;deepCopy;();;MapKey of Argument[-1];MapKey of ReturnValue;value",
        "android.os;Bundle;true;deepCopy;();;MapValue of Argument[-1];MapValue of ReturnValue;value",
        "android.os;Bundle;true;getBinder;(String);;MapValue of Argument[-1];ReturnValue;value",
        "android.os;Bundle;true;getBundle;(String);;MapValue of Argument[-1];ReturnValue;value",
        "android.os;Bundle;true;getByteArray;(String);;MapValue of Argument[-1];ReturnValue;value",
        "android.os;Bundle;true;getCharArray;(String);;MapValue of Argument[-1];ReturnValue;value",
        "android.os;Bundle;true;getCharSequence;(String);;MapValue of Argument[-1];ReturnValue;value",
        "android.os;Bundle;true;getCharSequence;(String,CharSequence);;MapValue of Argument[-1];ReturnValue;value",
        "android.os;Bundle;true;getCharSequence;(String,CharSequence);;Argument[1];ReturnValue;value",
        "android.os;Bundle;true;getCharSequenceArray;(String);;MapValue of Argument[-1];ReturnValue;value",
        "android.os;Bundle;true;getCharSequenceArrayList;(String);;MapValue of Argument[-1];ReturnValue;value",
        "android.os;Bundle;true;getParcelable;(String);;MapValue of Argument[-1];ReturnValue;value",
        "android.os;Bundle;true;getParcelableArray;(String);;MapValue of Argument[-1];ReturnValue;value",
        "android.os;Bundle;true;getParcelableArrayList;(String);;MapValue of Argument[-1];ReturnValue;value",
        "android.os;Bundle;true;getSerializable;(String);;MapValue of Argument[-1];ReturnValue;value",
        "android.os;Bundle;true;getSparseParcelableArray;(String);;MapValue of Argument[-1];ReturnValue;value",
        "android.os;Bundle;true;getStringArrayList;(String);;MapValue of Argument[-1];ReturnValue;value",
        "android.os;Bundle;true;putAll;(Bundle);;MapKey of Argument[0];MapKey of Argument[-1];value",
        "android.os;Bundle;true;putAll;(Bundle);;MapValue of Argument[0];MapValue of Argument[-1];value",
        "android.os;Bundle;true;putBinder;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;Bundle;true;putBinder;;;Argument[1];MapValue of Argument[-1];value",
        "android.os;Bundle;true;putBundle;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;Bundle;true;putBundle;;;Argument[1];MapValue of Argument[-1];value",
        "android.os;Bundle;true;putByte;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;Bundle;true;putByteArray;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;Bundle;true;putByteArray;;;Argument[1];MapValue of Argument[-1];value",
        "android.os;Bundle;true;putChar;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;Bundle;true;putCharArray;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;Bundle;true;putCharArray;;;Argument[1];MapValue of Argument[-1];value",
        "android.os;Bundle;true;putCharSequence;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;Bundle;true;putCharSequence;;;Argument[1];MapValue of Argument[-1];value",
        "android.os;Bundle;true;putCharSequenceArray;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;Bundle;true;putCharSequenceArray;;;Argument[1];MapValue of Argument[-1];value",
        "android.os;Bundle;true;putCharSequenceArrayList;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;Bundle;true;putCharSequenceArrayList;;;Argument[1];MapValue of Argument[-1];value",
        "android.os;Bundle;true;putFloat;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;Bundle;true;putFloatArray;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;Bundle;true;putIntegerArrayList;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;Bundle;true;putParcelable;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;Bundle;true;putParcelable;;;Argument[1];MapValue of Argument[-1];value",
        "android.os;Bundle;true;putParcelableArray;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;Bundle;true;putParcelableArray;;;Argument[1];MapValue of Argument[-1];value",
        "android.os;Bundle;true;putParcelableArrayList;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;Bundle;true;putParcelableArrayList;;;Argument[1];MapValue of Argument[-1];value",
        "android.os;Bundle;true;putSerializable;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;Bundle;true;putSerializable;;;Argument[1];MapValue of Argument[-1];value",
        "android.os;Bundle;true;putShort;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;Bundle;true;putShortArray;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;Bundle;true;putSize;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;Bundle;true;putSizeF;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;Bundle;true;putSparseParcelableArray;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;Bundle;true;putSparseParcelableArray;;;Argument[1];MapValue of Argument[-1];value",
        "android.os;Bundle;true;putStringArrayList;;;Argument[0];MapKey of Argument[-1];value",
        "android.os;Bundle;true;putStringArrayList;;;Argument[1];MapValue of Argument[-1];value",
        "android.os;Bundle;true;readFromParcel;;;Argument[0];MapKey of Argument[-1];taint",
        "android.os;Bundle;true;readFromParcel;;;Argument[0];MapValue of Argument[-1];taint",
        // currently only the Extras part of the intent and the data field are fully modelled
        "android.content;Intent;false;Intent;(Intent);;MapKey of SyntheticField[android.content.Intent.extras] of Argument[0];MapKey of SyntheticField[android.content.Intent.extras] of Argument[-1];value",
        "android.content;Intent;false;Intent;(Intent);;MapValue of SyntheticField[android.content.Intent.extras] of Argument[0];MapValue of SyntheticField[android.content.Intent.extras] of Argument[-1];value",
        "android.content;Intent;false;Intent;(String,Uri);;Argument[1];SyntheticField[android.content.Intent.data] of Argument[-1];value",
        "android.content;Intent;false;Intent;(String,Uri,Context,Class);;Argument[1];SyntheticField[android.content.Intent.data] of Argument[-1];value",
        "android.content;Intent;true;addCategory;;;Argument[-1];ReturnValue;value",
        "android.content;Intent;true;addFlags;;;Argument[-1];ReturnValue;value",
        "android.content;Intent;false;createChooser;;;Argument[0..2];MapValue of SyntheticField[android.content.Intent.extras] of ReturnValue;value",
        "android.content;Intent;true;getBundleExtra;(String);;MapValue of SyntheticField[android.content.Intent.extras] of Argument[-1];ReturnValue;value",
        "android.content;Intent;true;getByteArrayExtra;(String);;MapValue of SyntheticField[android.content.Intent.extras] of Argument[-1];ReturnValue;value",
        "android.content;Intent;true;getCharArrayExtra;(String);;MapValue of SyntheticField[android.content.Intent.extras] of Argument[-1];ReturnValue;value",
        "android.content;Intent;true;getCharSequenceArrayExtra;(String);;MapValue of SyntheticField[android.content.Intent.extras] of Argument[-1];ReturnValue;value",
        "android.content;Intent;true;getCharSequenceArrayListExtra;(String);;MapValue of SyntheticField[android.content.Intent.extras] of Argument[-1];ReturnValue;value",
        "android.content;Intent;true;getCharSequenceExtra;(String);;MapValue of SyntheticField[android.content.Intent.extras] of Argument[-1];ReturnValue;value",
        "android.content;Intent;true;getData;;;SyntheticField[android.content.Intent.data] of Argument[-1];ReturnValue;value",
        "android.content;Intent;true;getDataString;;;SyntheticField[android.content.Intent.data] of Argument[-1];ReturnValue;taint",
        "android.content;Intent;true;getExtras;();;SyntheticField[android.content.Intent.extras] of Argument[-1];ReturnValue;value",
        "android.content;Intent;false;getIntent;;;Argument[0];SyntheticField[android.content.Intent.data] of ReturnValue;taint",
        "android.content;Intent;false;getIntentOld;;;Argument[0];SyntheticField[android.content.Intent.data] of ReturnValue;taint",
        "android.content;Intent;true;getParcelableArrayExtra;(String);;MapValue of SyntheticField[android.content.Intent.extras] of Argument[-1];ReturnValue;value",
        "android.content;Intent;true;getParcelableArrayListExtra;(String);;MapValue of SyntheticField[android.content.Intent.extras] of Argument[-1];ReturnValue;value",
        "android.content;Intent;true;getParcelableExtra;(String);;MapValue of SyntheticField[android.content.Intent.extras] of Argument[-1];ReturnValue;value",
        "android.content;Intent;true;getSerializableExtra;(String);;MapValue of SyntheticField[android.content.Intent.extras] of Argument[-1];ReturnValue;value",
        "android.content;Intent;true;getStringArrayExtra;(String);;MapValue of SyntheticField[android.content.Intent.extras] of Argument[-1];ReturnValue;value",
        "android.content;Intent;true;getStringArrayListExtra;(String);;MapValue of SyntheticField[android.content.Intent.extras] of Argument[-1];ReturnValue;value",
        "android.content;Intent;true;getStringExtra;(String);;MapValue of SyntheticField[android.content.Intent.extras] of Argument[-1];ReturnValue;value",
        "android.content;Intent;false;parseUri;;;Argument[0];SyntheticField[android.content.Intent.data] of ReturnValue;taint",
        "android.content;Intent;true;putCharSequenceArrayListExtra;;;Argument[0];MapKey of SyntheticField[android.content.Intent.extras] of Argument[-1];value",
        "android.content;Intent;true;putCharSequenceArrayListExtra;;;Argument[1];MapValue of SyntheticField[android.content.Intent.extras] of Argument[-1];value",
        "android.content;Intent;true;putCharSequenceArrayListExtra;;;Argument[-1];ReturnValue;value",
        "android.content;Intent;true;putExtra;;;Argument[0];MapKey of SyntheticField[android.content.Intent.extras] of Argument[-1];value",
        "android.content;Intent;true;putExtra;;;Argument[1];MapValue of SyntheticField[android.content.Intent.extras] of Argument[-1];value",
        "android.content;Intent;true;putExtra;;;Argument[-1];ReturnValue;value",
        "android.content;Intent;true;putExtras;(Bundle);;MapKey of Argument[0];MapKey of SyntheticField[android.content.Intent.extras] of Argument[-1];value",
        "android.content;Intent;true;putExtras;(Bundle);;MapValue of Argument[0];MapValue of SyntheticField[android.content.Intent.extras] of Argument[-1];value",
        "android.content;Intent;true;putExtras;(Bundle);;Argument[-1];ReturnValue;value",
        "android.content;Intent;true;putExtras;(Intent);;MapKey of SyntheticField[android.content.Intent.extras] of Argument[0];MapKey of SyntheticField[android.content.Intent.extras] of Argument[-1];value",
        "android.content;Intent;true;putExtras;(Intent);;MapValue of SyntheticField[android.content.Intent.extras] of Argument[0];MapValue of SyntheticField[android.content.Intent.extras] of Argument[-1];value",
        "android.content;Intent;true;putExtras;(Intent);;Argument[-1];ReturnValue;value",
        "android.content;Intent;true;putIntegerArrayListExtra;;;Argument[0];MapKey of SyntheticField[android.content.Intent.extras] of Argument[-1];value",
        "android.content;Intent;true;putIntegerArrayListExtra;;;Argument[-1];ReturnValue;value",
        "android.content;Intent;true;putParcelableArrayListExtra;;;Argument[0];MapKey of SyntheticField[android.content.Intent.extras] of Argument[-1];value",
        "android.content;Intent;true;putParcelableArrayListExtra;;;Argument[1];MapValue of SyntheticField[android.content.Intent.extras] of Argument[-1];value",
        "android.content;Intent;true;putParcelableArrayListExtra;;;Argument[-1];ReturnValue;value",
        "android.content;Intent;true;putStringArrayListExtra;;;Argument[0];MapKey of SyntheticField[android.content.Intent.extras] of Argument[-1];value",
        "android.content;Intent;true;putStringArrayListExtra;;;Argument[1];MapValue of SyntheticField[android.content.Intent.extras] of Argument[-1];value",
        "android.content;Intent;true;putStringArrayListExtra;;;Argument[-1];ReturnValue;value",
        "android.content;Intent;true;replaceExtras;(Bundle);;MapKey of Argument[0];MapKey of SyntheticField[android.content.Intent.extras] of Argument[-1];value",
        "android.content;Intent;true;replaceExtras;(Bundle);;MapValue of Argument[0];MapValue of SyntheticField[android.content.Intent.extras] of Argument[-1];value",
        "android.content;Intent;true;replaceExtras;(Bundle);;Argument[-1];ReturnValue;value",
        "android.content;Intent;true;replaceExtras;(Intent);;MapKey of SyntheticField[android.content.Intent.extras] of Argument[0];MapKey of SyntheticField[android.content.Intent.extras] of Argument[-1];value",
        "android.content;Intent;true;replaceExtras;(Intent);;MapValue of SyntheticField[android.content.Intent.extras] of Argument[0];MapValue of SyntheticField[android.content.Intent.extras] of Argument[-1];value",
        "android.content;Intent;true;replaceExtras;(Intent);;Argument[-1];ReturnValue;value",
        "android.content;Intent;true;setAction;;;Argument[-1];ReturnValue;value",
        "android.content;Intent;true;setClass;;;Argument[-1];ReturnValue;value",
        "android.content;Intent;true;setClassName;;;Argument[-1];ReturnValue;value",
        "android.content;Intent;true;setComponent;;;Argument[-1];ReturnValue;value",
        "android.content;Intent;true;setData;;;Argument[-1];ReturnValue;value",
        "android.content;Intent;true;setData;;;Argument[0];SyntheticField[android.content.Intent.data] of Argument[-1];value",
        "android.content;Intent;true;setDataAndNormalize;;;Argument[-1];ReturnValue;value",
        "android.content;Intent;true;setDataAndNormalize;;;Argument[0];SyntheticField[android.content.Intent.data] of Argument[-1];value",
        "android.content;Intent;true;setDataAndType;;;Argument[-1];ReturnValue;value",
        "android.content;Intent;true;setDataAndType;;;Argument[0];SyntheticField[android.content.Intent.data] of Argument[-1];value",
        "android.content;Intent;true;setDataAndTypeAndNormalize;;;Argument[-1];ReturnValue;value",
        "android.content;Intent;true;setDataAndTypeAndNormalize;;;Argument[0];SyntheticField[android.content.Intent.data] of Argument[-1];value",
        "android.content;Intent;true;setFlags;;;Argument[-1];ReturnValue;value",
        "android.content;Intent;true;setIdentifier;;;Argument[-1];ReturnValue;value",
        "android.content;Intent;true;setPackage;;;Argument[-1];ReturnValue;value",
        "android.content;Intent;true;setType;;;Argument[-1];ReturnValue;value",
        "android.content;Intent;true;setTypeAndNormalize;;;Argument[-1];ReturnValue;value"
      ]
  }
}

private class IntentComponentTaintSteps extends SummaryModelCsv {
  override predicate row(string s) {
    s =
      [
        "android.content;Intent;true;Intent;(Intent);;Argument[0];Argument[-1];taint",
        "android.content;Intent;true;Intent;(Context,Class);;Argument[1];Argument[-1];taint",
        "android.content;Intent;true;Intent;(String,Uri,Context,Class);;Argument[3];Argument[-1];taint",
        "android.content;Intent;true;getIntent;(String);;Argument[0];ReturnValue;taint",
        "android.content;Intent;true;getIntentOld;(String);;Argument[0];ReturnValue;taint",
        "android.content;Intent;true;parseUri;(String,int);;Argument[0];ReturnValue;taint",
        "android.content;Intent;true;setPackage;;;Argument[0];Argument[-1];taint",
        "android.content;Intent;true;setClass;;;Argument[1];Argument[-1];taint",
        "android.content;Intent;true;setClassName;(Context,String);;Argument[1];Argument[-1];taint",
        "android.content;Intent;true;setClassName;(String,String);;Argument[0..1];Argument[-1];taint",
        "android.content;Intent;true;setComponent;;;Argument[0];Argument[-1];taint",
        "android.content;ComponentName;false;ComponentName;(String,String);;Argument[0..1];Argument[-1];taint",
        "android.content;ComponentName;false;ComponentName;(Context,String);;Argument[1];Argument[-1];taint",
        "android.content;ComponentName;false;ComponentName;(Context,Class);;Argument[1];Argument[-1];taint",
        "android.content;ComponentName;false;ComponentName;(Parcel);;Argument[0];Argument[-1];taint",
        "android.content;ComponentName;false;createRelative;(String,String);;Argument[0..1];ReturnValue;taint",
        "android.content;ComponentName;false;createRelative;(Context,String);;Argument[1];ReturnValue;taint",
        "android.content;ComponentName;false;flattenToShortString;;;Argument[-1];ReturnValue;taint",
        "android.content;ComponentName;false;flattenToString;;;Argument[-1];ReturnValue;taint",
        "android.content;ComponentName;false;getClassName;;;Argument[-1];ReturnValue;taint",
        "android.content;ComponentName;false;getPackageName;;;Argument[-1];ReturnValue;taint",
        "android.content;ComponentName;false;getShortClassName;;;Argument[-1];ReturnValue;taint",
        "android.content;ComponentName;false;unflattenFromString;;;Argument[0];ReturnValue;taint"
      ]
  }
}
