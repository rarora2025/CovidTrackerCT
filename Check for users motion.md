---


---

<pre><code>override func viewDidLoad() {
    super.viewDidLoad()
    self.becomeFirstResponder() // To get shake gesture
}

// We are willing to become first responder to get shake motion
override var canBecomeFirstResponder: Bool {
    get {
        return true
    }
}

// Enable detection of shake motion
override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
    if motion == .motionShake {
        print("Why are you shaking me?")
    }
}
</code></pre>

