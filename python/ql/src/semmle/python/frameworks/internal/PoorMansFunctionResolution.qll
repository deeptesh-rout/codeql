/**
 * INTERNAL: Do not use.
 *
 * Notice: The predicates provided in this module is a poor mans solution for function
 * resolution, and does not handle anything but the most simple cases.
 *
 * For example, in the code below, we're not able to tell anything about
 * `inst.my_method` (which is a bound-method)
 * ```py
 * class MyClass:
 *     def my_method(self):
 *         pass
 *
 * inst = MyClass()
 * print(inst.my_method)
 * ```
 */

private import python
private import semmle.python.dataflow.new.DataFlow

/**
 * Gets the last decorator call for the function `func`, if `func` has decorators.
 */
private Expr lastDecoratorCall(Function func) {
  result = func.getDefinition().(FunctionExpr).getADecoratorCall() and
  not exists(Call other_decorator | other_decorator.getArg(0) = result)
}

/**
 * Gets a reference to the Function `func`.
 *
 * Notice: This is a poor mans solution for function resolution, and does not handle
 * anything but the most simple cases.
 *
 * For example, in the code below, we're not able to tell anything about
 * `inst.my_method` (which is a bound-method)
 * ```py
 * class MyClass:
 *     def my_method(self):
 *         pass
 *
 * inst = MyClass()
 * print(inst.my_method)
 * ```
 */
private DataFlow::TypeTrackingNode poorMansFunctionTracker(DataFlow::TypeTracker t, Function func) {
  t.start() and
  (
    not exists(func.getADecorator()) and
    result.asExpr() = func.getDefinition()
    or
    // If the function has decorators, we still want to model the function as being
    // the request handler for a route setup. In such situations, we must track the
    // last decorator call instead of the function itself.
    //
    // Note that this means that we blindly ignore what the decorator actually does to
    // the function, which seems like an OK tradeoff.
    result.asExpr() = lastDecoratorCall(func)
  )
  or
  exists(DataFlow::TypeTracker t2 | result = poorMansFunctionTracker(t2, func).track(t2, t))
}

/**
 * INTERNAL: Do not use.
 *
 * Gets a reference to the Function `func`.
 *
 * Notice: This is a poor mans solution for function resolution, and does not handle
 * anything but the most simple cases.
 *
 * For example, in the code below, we're not able to tell anything about
 * `inst.my_method` (which is a bound-method)
 * ```py
 * class MyClass:
 *     def my_method(self):
 *         pass
 *
 * inst = MyClass()
 * print(inst.my_method)
 * ```
 */
DataFlow::Node poorMansFunctionTracker(Function func) {
  poorMansFunctionTracker(DataFlow::TypeTracker::end(), func).flowsTo(result)
}
