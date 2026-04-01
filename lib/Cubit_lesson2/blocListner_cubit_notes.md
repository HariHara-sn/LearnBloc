**BlocListener** is super simple — but extremely useful in real apps.
This is what companies expect you to know when using BLoC or Cubit.

I’ll explain everything in a clear, practical way with a small example.

---

# 🎧 **What is BlocListener?**

**BlocListener** listens to state changes and performs **one-time actions** like:

* Showing Snackbar
* Showing Dialog
* Navigating to another page
* Showing a Toast
* Logging analytics

👉 **It does NOT rebuild UI.**
👉 Only reacts once when the state changes.

That’s the whole purpose.

---

# 🎬 **Why do we use BlocListener?**

Because some things should **not rebuild UI**, only react.

Example:
When login is successful → navigate to home.
When login fails → show Snackbar.

If you put this inside `BlocBuilder`, your UI will rebuild unnecessarily.

So:

| Task               | Use          |
| ------------------ | ------------ |
| Rebuilding UI      | BlocBuilder  |
| Performing Actions | BlocListener |

---

# 🧪 **Mini Example (Cubit + BlocListener)**

Let’s create a simple Cubit that emits 3 states:

* `Initial`
* `Loading`
* `Success`

When Success happens → Show a Snackbar.

---

## 📌 **Step 1: Create States**

```dart
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {}
```

---

## 📌 **Step 2: Create Cubit**

```dart
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void login() async {
    emit(LoginLoading());

    await Future.delayed(Duration(seconds: 2)); // fake API call

    emit(LoginSuccess());
  }
}
```

---

## 📌 **Step 3: Use BlocListener in UI**

```dart
BlocListener<LoginCubit, LoginState>(
  listener: (context, state) {
    if (state is LoginSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Successful!")),
      );
    }
  },
  child: MyLoginUI(),
)
```

👉 The `listener` function runs only when state changes.
👉 It **does not rebuild UI**.
👉 `child` = UI remains untouched.

---

# ✔️ **Explain the Code in Simple English**

### 1️⃣ `BlocListener<LoginCubit, LoginState>`

This means:

* Listen to LoginCubit
* React when its state changes

### 2️⃣ `listener: (context, state) { ... }`

This block is executed **only when a new state comes**.

### 3️⃣ `if (state is LoginSuccess)`

We check if login is successful.

### 4️⃣ `SnackBar`

We display a message — no UI rebuild needed.

---

# 🧠 **When will you use BlocListener in real apps?**

## 🔹 Login

* On success → Navigate to dashboard
* On failure → Show error

## 🔹 Signup

* Show verification email message

## 🔹 Payments

* Show “Payment Successful”
* Redirect to orders page

## 🔹 OTP screens

* If OTP verified → Navigate
* If wrong OTP → Show error

## 🔹 Add-to-cart

* Show “Item Added” message

Whenever you need **one-time side effects**, BlocListener is the tool.

---

# 🧩 **Can you use BlocBuilder + BlocListener together?**

YES.

Sometimes you need **UI rebuild + reaction**.

That’s where **BlocConsumer** comes in.
We will learn that next if you’re ready.

---

# 🚀 Hari, your next step:

👉 **Teach me BlocConsumer**
or
👉 **Move to Full BLoC (Events + States)**
