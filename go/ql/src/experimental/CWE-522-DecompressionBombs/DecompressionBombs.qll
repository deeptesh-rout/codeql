import go

module DecompressionBombs {
  class FlowState = DataFlow::FlowState;

  /**
   * the Sinks of uncontrolled data decompression
   */
  class Sink extends DataFlow::Node {
    Sink() { this = any(Range r).sink() }
  }

  /**
   * The additional taint steps that need for creating taint tracking or dataflow.
   */
  abstract class AdditionalTaintStep extends string {
    AdditionalTaintStep() { this = "AdditionalTaintStep" }

    /**
     * Holds if there is a additional taint step between pred and succ.
     */
    abstract predicate isAdditionalFlowStep(DataFlow::Node fromNode, DataFlow::Node toNode);

    /**
     * Holds if there is a additional taint step between pred and succ.
     */
    abstract predicate isAdditionalFlowStep(
      DataFlow::Node fromNode, FlowState fromState, DataFlow::Node toNode, FlowState toState
    );
  }

  /**
   * A abstract class responsible for extending new decompression sinks
   */
  abstract private class Range extends DataFlow::Node {
    /**
     * Gets the sink of responsible for decompression node
     *
     * it can be a path, stream of compressed data,
     * or a call to function that use pipe
     */
    abstract DataFlow::Node sink();
  }

  module DataDogZstd {
    class TheSink extends Range {
      TheSink() {
        exists(Method f |
          f.hasQualifiedName("github.com/klauspost/compress/zstd", "Decoder", "Read")
        |
          this = f.getACall().getReceiver()
        )
      }

      override DataFlow::Node sink() { result = this }
    }

    class TheAdditionalTaintStep extends AdditionalTaintStep {
      TheAdditionalTaintStep() { this = "AdditionalTaintStep" }

      override predicate isAdditionalFlowStep(
        DataFlow::Node fromNode, FlowState fromState, DataFlow::Node toNode, FlowState toState
      ) {
        exists(Function f, DataFlow::CallNode call |
          f.hasQualifiedName("github.com/DataDog/zstd", "NewReader") and
          call = f.getACall()
        |
          fromNode = call.getArgument(0) and
          toNode = call.getResult(0) and
          fromState = "" and
          toState = "ZstdNewReader"
        )
      }

      override predicate isAdditionalFlowStep(DataFlow::Node fromNode, DataFlow::Node toNode) {
        none()
      }
    }
  }

  module KlauspostZstd {
    class TheSink extends Range {
      TheSink() {
        exists(Method f |
          f.hasQualifiedName("github.com/klauspost/compress/zstd", "Decoder",
            ["WriteTo", "DecodeAll"])
        |
          this = f.getACall().getReceiver()
        )
        or
        exists(Method f |
          f.hasQualifiedName("github.com/klauspost/compress/zstd", "Decoder", "Read")
        |
          this = f.getACall().getReceiver()
        )
      }

      override DataFlow::Node sink() { result = this }
    }

    class TheAdditionalTaintStep extends AdditionalTaintStep {
      TheAdditionalTaintStep() { this = "AdditionalTaintStep" }

      override predicate isAdditionalFlowStep(
        DataFlow::Node fromNode, FlowState fromState, DataFlow::Node toNode, FlowState toState
      ) {
        exists(Function f, DataFlow::CallNode call |
          f.hasQualifiedName("github.com/klauspost/compress/zstd", "NewReader") and
          call = f.getACall()
        |
          fromNode = call.getArgument(0) and
          toNode = call.getResult(0) and
          fromState = "" and
          toState = "ZstdNewReader"
        )
      }

      override predicate isAdditionalFlowStep(DataFlow::Node fromNode, DataFlow::Node toNode) {
        none()
      }
    }
  }

  module ArchiveZip {
    class TheAdditionalTaintStep extends AdditionalTaintStep {
      TheAdditionalTaintStep() { this = "AdditionalTaintStep" }

      override predicate isAdditionalFlowStep(
        DataFlow::Node fromNode, FlowState fromState, DataFlow::Node toNode, FlowState toState
      ) {
        exists(Function f, DataFlow::CallNode call |
          f.hasQualifiedName("archive/zip", ["OpenReader", "NewReader"]) and call = f.getACall()
        |
          fromNode = call.getArgument(0) and
          toNode = call.getResult(0) and
          fromState = "" and
          toState = "ZipOpenReader"
        )
      }

      override predicate isAdditionalFlowStep(DataFlow::Node fromNode, DataFlow::Node toNode) {
        none()
      }
    }
  }

  module KlauspostZip {
    class TheSink extends Range {
      TheSink() {
        exists(Method f |
          f.hasQualifiedName("github.com/klauspost/compress/zstd", "Decoder",
            ["WriteTo", "DecodeAll"])
        |
          this = f.getACall().getReceiver()
        )
        or
        exists(Method f |
          f.hasQualifiedName("github.com/klauspost/compress/zstd", "Decoder", "Read")
        |
          this = f.getACall().getReceiver()
        )
      }

      override DataFlow::Node sink() { result = this }
    }

    class TheAdditionalTaintStep extends AdditionalTaintStep {
      TheAdditionalTaintStep() { this = "AdditionalTaintStep" }

      override predicate isAdditionalFlowStep(
        DataFlow::Node fromNode, FlowState fromState, DataFlow::Node toNode, FlowState toState
      ) {
        exists(Function f, DataFlow::CallNode call |
          f.hasQualifiedName("github.com/klauspost/compress/zip", ["NewReader", "OpenReader"]) and
          call = f.getACall()
        |
          fromNode = call.getArgument(0) and
          toNode = call.getResult(0) and
          fromState = "" and
          toState = "ZipKlauspost"
        )
      }

      override predicate isAdditionalFlowStep(DataFlow::Node fromNode, DataFlow::Node toNode) {
        exists(DataFlow::FieldReadNode fi |
          fi.getType().hasQualifiedName("github.com/klauspost/compress/zip", "Reader")
        |
          fromNode = fi.getBase() and
          toNode = fi
        )
        or
        exists(Method f, DataFlow::CallNode call |
          f.hasQualifiedName("github.com/klauspost/compress/zip", "File", ["Open", "OpenRaw"]) and
          call = f.getACall()
        |
          fromNode = call.getReceiver() and
          toNode = call
        )
      }
    }
  }

  module UlikunitzXz {
    class TheSink extends Range {
      TheSink() {
        exists(Method f | f.hasQualifiedName("github.com/ulikunitz/xz", "Reader", "Read") |
          this = f.getACall().getReceiver()
        )
      }

      override DataFlow::Node sink() { result = this }
    }

    class TheAdditionalTaintStep extends AdditionalTaintStep {
      TheAdditionalTaintStep() { this = "AdditionalTaintStep" }

      override predicate isAdditionalFlowStep(
        DataFlow::Node fromNode, FlowState fromState, DataFlow::Node toNode, FlowState toState
      ) {
        exists(Function f, DataFlow::CallNode call |
          f.hasQualifiedName("github.com/ulikunitz/xz", "NewReader") and call = f.getACall()
        |
          fromNode = call.getArgument(0) and
          toNode = call.getResult(0) and
          fromState = "" and
          toState = "XzNewReader"
        )
      }

      override predicate isAdditionalFlowStep(DataFlow::Node fromNode, DataFlow::Node toNode) {
        none()
      }
    }
  }

  module CompressGzip {
    class TheSink extends Range {
      TheSink() {
        exists(Method f | f.hasQualifiedName("compress/gzip", "Reader", "Read") |
          this = f.getACall().getReceiver()
        )
      }

      override DataFlow::Node sink() { result = this }
    }

    class TheAdditionalTaintStep extends AdditionalTaintStep {
      TheAdditionalTaintStep() { this = "AdditionalTaintStep" }

      override predicate isAdditionalFlowStep(
        DataFlow::Node fromNode, FlowState fromState, DataFlow::Node toNode, FlowState toState
      ) {
        exists(Function f, DataFlow::CallNode call |
          f.hasQualifiedName("compress/gzip", "NewReader") and
          call = f.getACall()
        |
          fromNode = call.getArgument(0) and
          toNode = call.getResult(0) and
          fromState = "" and
          toState = "GzipNewReader"
        )
      }

      override predicate isAdditionalFlowStep(DataFlow::Node fromNode, DataFlow::Node toNode) {
        none()
      }
    }
  }

  module KlauspostGzip {
    class TheSink extends Range {
      TheSink() {
        exists(Method f |
          f.hasQualifiedName("github.com/klauspost/compress/gzip", "Reader", "Read")
        |
          this = f.getACall().getReceiver()
        )
        or
        exists(Method f |
          f.hasQualifiedName(["github.com/klauspost/compress/gzip", "github.com/klauspost/pgzip"],
            "Reader", "WriteTo")
        |
          this = f.getACall().getReceiver()
        )
      }

      override DataFlow::Node sink() { result = this }
    }

    class TheAdditionalTaintStep extends AdditionalTaintStep {
      TheAdditionalTaintStep() { this = "AdditionalTaintStep" }

      override predicate isAdditionalFlowStep(
        DataFlow::Node fromNode, FlowState fromState, DataFlow::Node toNode, FlowState toState
      ) {
        exists(Function f, DataFlow::CallNode call |
          f.hasQualifiedName(["github.com/klauspost/compress/gzip", "github.com/klauspost/pgzip"],
            "NewReader") and
          call = f.getACall()
        |
          fromNode = call.getArgument(0) and
          toNode = call.getResult(0) and
          fromState = "" and
          toState = "GzipNewReader"
        )
      }

      override predicate isAdditionalFlowStep(DataFlow::Node fromNode, DataFlow::Node toNode) {
        none()
      }
    }
  }

  module CompressBzip2 {
    class TheSink extends Range {
      TheSink() {
        exists(Method f | f.hasQualifiedName("compress/bzip2", "reader", "Read") |
          this = f.getACall().getReceiver()
        )
      }

      override DataFlow::Node sink() { result = this }
    }

    class TheAdditionalTaintStep extends AdditionalTaintStep {
      TheAdditionalTaintStep() { this = "AdditionalTaintStep" }

      override predicate isAdditionalFlowStep(
        DataFlow::Node fromNode, FlowState fromState, DataFlow::Node toNode, FlowState toState
      ) {
        exists(Function f, DataFlow::CallNode call |
          f.hasQualifiedName("compress/bzip2", "NewReader") and
          call = f.getACall()
        |
          fromNode = call.getArgument(0) and
          toNode = call.getResult(0) and
          fromState = "" and
          toState = "Bzip2NewReader"
        )
      }

      override predicate isAdditionalFlowStep(DataFlow::Node fromNode, DataFlow::Node toNode) {
        none()
      }
    }
  }

  module DsnetBzip2 {
    class TheSink extends Range {
      TheSink() {
        exists(Method f | f.hasQualifiedName("github.com/dsnet/compress/bzip2", "Reader", "Read") |
          this = f.getACall().getReceiver()
        )
      }

      override DataFlow::Node sink() { result = this }
    }

    class TheAdditionalTaintStep extends AdditionalTaintStep {
      TheAdditionalTaintStep() { this = "AdditionalTaintStep" }

      override predicate isAdditionalFlowStep(
        DataFlow::Node fromNode, FlowState fromState, DataFlow::Node toNode, FlowState toState
      ) {
        exists(Function f, DataFlow::CallNode call |
          f.hasQualifiedName("github.com/dsnet/compress/bzip2", "NewReader") and
          call = f.getACall()
        |
          fromNode = call.getArgument(0) and
          toNode = call.getResult(0) and
          fromState = "" and
          toState = "Bzip2NewReader"
        )
      }

      override predicate isAdditionalFlowStep(DataFlow::Node fromNode, DataFlow::Node toNode) {
        none()
      }
    }
  }

  module DsnetFlate {
    class TheSink extends Range {
      TheSink() {
        exists(Method f | f.hasQualifiedName("github.com/dsnet/compress/flate", "Reader", "Read") |
          this = f.getACall().getReceiver()
        )
      }

      override DataFlow::Node sink() { result = this }
    }

    class TheAdditionalTaintStep extends AdditionalTaintStep {
      TheAdditionalTaintStep() { this = "AdditionalTaintStep" }

      override predicate isAdditionalFlowStep(
        DataFlow::Node fromNode, FlowState fromState, DataFlow::Node toNode, FlowState toState
      ) {
        exists(Function f, DataFlow::CallNode call |
          f.hasQualifiedName("github.com/dsnet/compress/flate", "NewReader") and
          call = f.getACall()
        |
          fromNode = call.getArgument(0) and
          toNode = call.getResult(0) and
          fromState = "" and
          toState = "FlateNewReader"
        )
      }

      override predicate isAdditionalFlowStep(DataFlow::Node fromNode, DataFlow::Node toNode) {
        none()
      }
    }
  }

  module CompressFlate {
    class TheSink extends Range {
      TheSink() {
        exists(Method f | f.hasQualifiedName("compress/flate", "decompressor", "Read") |
          this = f.getACall().getReceiver()
        )
      }

      override DataFlow::Node sink() { result = this }
    }

    class TheAdditionalTaintStep extends AdditionalTaintStep {
      TheAdditionalTaintStep() { this = "AdditionalTaintStep" }

      override predicate isAdditionalFlowStep(
        DataFlow::Node fromNode, FlowState fromState, DataFlow::Node toNode, FlowState toState
      ) {
        exists(Function f, DataFlow::CallNode call |
          f.hasQualifiedName("compress/flate", ["NewReaderDict", "NewReader"]) and
          call = f.getACall()
        |
          fromNode = call.getArgument(0) and
          toNode = call.getResult(0) and
          fromState = "" and
          toState = "FlateNewReader"
        )
      }

      override predicate isAdditionalFlowStep(DataFlow::Node fromNode, DataFlow::Node toNode) {
        none()
      }
    }
  }

  module KlauspostFlate {
    class TheSink extends Range {
      TheSink() {
        exists(Method f |
          f.hasQualifiedName("github.com/klauspost/compress/flate", "decompressor", "Read")
        |
          this = f.getACall().getReceiver()
        )
      }

      override DataFlow::Node sink() { result = this }
    }

    class TheAdditionalTaintStep extends AdditionalTaintStep {
      TheAdditionalTaintStep() { this = "AdditionalTaintStep" }

      override predicate isAdditionalFlowStep(
        DataFlow::Node fromNode, FlowState fromState, DataFlow::Node toNode, FlowState toState
      ) {
        exists(Function f, DataFlow::CallNode call |
          f.hasQualifiedName(["github.com/klauspost/compress/flate"], ["NewReaderDict", "NewReader"]) and
          call = f.getACall()
        |
          fromNode = call.getArgument(0) and
          toNode = call.getResult(0) and
          fromState = "" and
          toState = "FlateNewReader"
        )
      }

      override predicate isAdditionalFlowStep(DataFlow::Node fromNode, DataFlow::Node toNode) {
        none()
      }
    }
  }

  module KlauspostZlib {
    class TheSink extends Range {
      TheSink() {
        exists(Method f |
          f.hasQualifiedName("github.com/klauspost/compress/zlib", "reader", "Read")
        |
          this = f.getACall().getReceiver()
        )
      }

      override DataFlow::Node sink() { result = this }
    }

    class TheAdditionalTaintStep extends AdditionalTaintStep {
      TheAdditionalTaintStep() { this = "AdditionalTaintStep" }

      override predicate isAdditionalFlowStep(
        DataFlow::Node fromNode, FlowState fromState, DataFlow::Node toNode, FlowState toState
      ) {
        exists(Function f, DataFlow::CallNode call |
          f.hasQualifiedName("github.com/klauspost/compress/zlib", "NewReader") and
          call = f.getACall()
        |
          fromNode = call.getArgument(0) and
          toNode = call.getResult(0) and
          fromState = "" and
          toState = "ZlibNewReader"
        )
      }

      override predicate isAdditionalFlowStep(DataFlow::Node fromNode, DataFlow::Node toNode) {
        none()
      }
    }
  }

  module CompressZlib {
    class TheSink extends Range {
      TheSink() {
        exists(Method f | f.hasQualifiedName("compress/zlib", "reader", "Read") |
          this = f.getACall().getReceiver()
        )
      }

      override DataFlow::Node sink() { result = this }
    }

    class TheAdditionalTaintStep extends AdditionalTaintStep {
      TheAdditionalTaintStep() { this = "AdditionalTaintStep" }

      override predicate isAdditionalFlowStep(
        DataFlow::Node fromNode, FlowState fromState, DataFlow::Node toNode, FlowState toState
      ) {
        exists(Function f, DataFlow::CallNode call |
          f.hasQualifiedName("compress/zlib", "NewReader") and
          call = f.getACall()
        |
          fromNode = call.getArgument(0) and
          toNode = call.getResult(0) and
          fromState = "" and
          toState = "ZlibNewReader"
        )
      }

      override predicate isAdditionalFlowStep(DataFlow::Node fromNode, DataFlow::Node toNode) {
        none()
      }
    }
  }

  module GolangSnappy {
    class TheSink extends Range {
      TheSink() {
        exists(Method f |
          f.hasQualifiedName("github.com/golang/snappy", "Reader", ["Read", "ReadByte"])
        |
          this = f.getACall().getReceiver()
        )
      }

      override DataFlow::Node sink() { result = this }
    }

    class TheAdditionalTaintStep extends AdditionalTaintStep {
      TheAdditionalTaintStep() { this = "AdditionalTaintStep" }

      override predicate isAdditionalFlowStep(
        DataFlow::Node fromNode, FlowState fromState, DataFlow::Node toNode, FlowState toState
      ) {
        exists(Function f, DataFlow::CallNode call |
          f.hasQualifiedName("github.com/golang/snappy", "NewReader") and
          call = f.getACall()
        |
          fromNode = call.getArgument(0) and
          toNode = call.getResult(0) and
          fromState = "" and
          toState = "SnapyNewReader"
        )
      }

      override predicate isAdditionalFlowStep(DataFlow::Node fromNode, DataFlow::Node toNode) {
        none()
      }
    }
  }

  module KlauspostSnappy {
    class TheAdditionalTaintStep extends AdditionalTaintStep {
      TheAdditionalTaintStep() { this = "AdditionalTaintStep" }

      override predicate isAdditionalFlowStep(
        DataFlow::Node fromNode, FlowState fromState, DataFlow::Node toNode, FlowState toState
      ) {
        exists(Function f, DataFlow::CallNode call |
          f.hasQualifiedName("github.com/klauspost/compress/snappy", "NewReader") and
          call = f.getACall()
        |
          fromNode = call.getArgument(0) and
          toNode = call.getResult(0) and
          fromState = "" and
          toState = "SnapyNewReader"
        )
      }

      override predicate isAdditionalFlowStep(DataFlow::Node fromNode, DataFlow::Node toNode) {
        none()
      }
    }
  }

  module KlauspostS2 {
    class TheSink extends Range {
      TheSink() {
        exists(Function f |
          f.hasQualifiedName("github.com/klauspost/compress/s2.Reader",
            ["DecodeConcurrent", "ReadByte", "Read"])
        |
          this = f.getACall().getReceiver()
        )
      }

      override DataFlow::Node sink() { result = this }
    }

    class TheAdditionalTaintStep extends AdditionalTaintStep {
      TheAdditionalTaintStep() { this = "AdditionalTaintStep" }

      override predicate isAdditionalFlowStep(
        DataFlow::Node fromNode, FlowState fromState, DataFlow::Node toNode, FlowState toState
      ) {
        exists(Function f, DataFlow::CallNode call |
          f.hasQualifiedName("github.com/klauspost/compress/s2", "NewReader") and
          call = f.getACall()
        |
          fromNode = call.getArgument(0) and
          toNode = call.getResult(0) and
          fromState = "" and
          toState = "S2NewReader"
        )
      }

      override predicate isAdditionalFlowStep(DataFlow::Node fromNode, DataFlow::Node toNode) {
        none()
      }
    }
  }

  module ArchiveTar {
    class TheSink extends Range {
      TheSink() {
        exists(Method f | f.hasQualifiedName("archive/tar", "Reader", "Read") |
          this = f.getACall().getReceiver()
        )
      }

      override DataFlow::Node sink() { result = this }
    }
  }

  module GeneralReadIoSink {
    class TheSink extends Range {
      TheSink() {
        exists(Function f | f.hasQualifiedName("io", ["Copy", "CopyBuffer", "CopyN"]) |
          this = f.getACall().getArgument(1)
        )
        or
        exists(Function f |
          f.hasQualifiedName("io", ["Pipe", "ReadAll", "ReadAtLeast", "ReadFull"])
        |
          this = f.getACall().getArgument(0)
        )
        or
        exists(Method f |
          f.hasQualifiedName("bufio", "Reader",
            ["Read", "ReadBytes", "ReadByte", "ReadLine", "ReadRune", "ReadSlice", "ReadString"])
        |
          this = f.getACall().getReceiver()
        )
        or
        exists(Method f | f.hasQualifiedName("bufio", "Scanner", ["Text", "Bytes"]) |
          this = f.getACall().getReceiver()
        )
        or
        exists(Function f | f.hasQualifiedName("io/ioutil", "ReadAll") |
          this = f.getACall().getArgument(0)
        )
      }

      override DataFlow::Node sink() { result = this }
    }
  }
}
