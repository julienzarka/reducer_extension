/// Provides annotation class to use with
/// [reducer_extension_gen](https://pub.dev/packages/reducer_extension_gen).
library reducer_extension;

/// Annotation used to indicate that the `Reducer` extension should be generated.
const reducer = Reducer();

class Reducer {
  /// Creates a new [Reducer] instance.
  const Reducer();
}
