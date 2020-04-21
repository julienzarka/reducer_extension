/// Provides annotation class to use with
/// [reducer_extension_gen](https://pub.dev/packages/reducer_extension_gen).
library reducer_extension;

/// Annotation used to indicate that the `ActionReducer` extension should be generated.
const actionReducer = ActionReducer();

class ActionReducer {
  /// Creates a new [ActionReducer] instance.
  const ActionReducer();
}
