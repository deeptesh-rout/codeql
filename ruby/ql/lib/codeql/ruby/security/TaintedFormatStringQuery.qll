/**
 * Provides a taint-tracking configuration for reasoning about format string
 * injections.
 *
 *
 * Note, for performance reasons: only import this file if
 * `TaintedFormatStringFlow` is needed, otherwise
 * `TaintedFormatStringCustomizations` should be imported instead.
 */

private import TaintedFormatStringCustomizations::TaintedFormatString

/**
 * A taint-tracking configuration for format string injections.
 * DEPRECATED: Use `TaintedFormatStringFlow`
 */
deprecated class Configuration extends TaintTracking::Configuration {
  Configuration() { this = "TaintedFormatString" }

  override predicate isSource(DataFlow::Node source) { source instanceof Source }

  override predicate isSink(DataFlow::Node sink) { sink instanceof Sink }

  override predicate isSanitizer(DataFlow::Node node) {
    super.isSanitizer(node) or
    node instanceof Sanitizer
  }
}

private module TaintedFormatStringConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) { source instanceof Source }

  predicate isSink(DataFlow::Node sink) { sink instanceof Sink }

  predicate isBarrier(DataFlow::Node node) { node instanceof Sanitizer }
}

/**
 * Taint-tracking for format string injections.
 */
module TaintedFormatStringFlow = TaintTracking::Global<TaintedFormatStringConfig>;
