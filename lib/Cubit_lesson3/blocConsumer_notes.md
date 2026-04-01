Sure Hari — here’s a clean, simple **BlocConsumer notes sheet** you can save and reuse anytime.
Short, clear, and exactly what you need.

---

# 📘 **BlocConsumer — Quick Notes**

### ✅ **What BlocConsumer does**

`BlocConsumer` is a widget that **combines**:

* **BlocBuilder** → rebuilds UI based on state
* **BlocListener** → runs side effects (snackbar, navigation, dialogs)

You use it when you need **both UI updates + reactions** in one widget.

---

# 🧩 **BlocConsumer Structure**

```dart
BlocConsumer<YourCubit, YourState>(
  listener: (context, state) {
    // Side effects (no UI return)
  },
  builder: (context, state) {
    // Return UI based on state
  },
)
```

---

# 🎯 **listener**

* Does **NOT** return widgets
* For **one-time actions**:

  * showSnackBar
  * showDialog
  * showBottomSheet
  * Navigation
  * Printing logs

Listener only *reacts* to changes.

---

# 🎨 **builder**

* Must **return a widget**
* Builds UI **according to current state**
* Called every time the state changes (unless filtered)

Example:

```dart
builder: (context, state) {
  if (state is LoadingState) return CircularProgressIndicator();
  if (state is ErrorState)   return Text("Something went wrong");
  return NormalUI();
}
```

---

# 📌 **Common Use Cases**

* Login / Signup forms
* API requests (loading → success → error)
* Cart updates
* Form validation
* CRUD operations (loading → done → reload UI)

---

# 🔎 **Key Points to Remember**

* listener = **actions**, builder = **UI**
* listener does NOT rebuild UI
* builder must ALWAYS return a widget
* Use `BlocConsumer` only when you need **both** actions + UI changes
* Otherwise prefer:

  * BlocBuilder → UI only
  * BlocListener → side effects only

---

# 💡 Extra Tip

You can control when listener/builder runs using:

```dart
listenWhen: (previous, current) => true,
buildWhen:  (previous, current) => true,
```

Useful when you want to ignore certain states.

---

# ⭐ One-Line Summary

**BlocConsumer = BlocBuilder + BlocListener in one widget — used when your UI must update AND you need to perform side effects when state changes.**

---

If you'd like, I can also create a similar notes page for:

✓ BlocProvider
✓ BlocBuilder
✓ BlocListener

