---


---

<p>changing user to dark mode</p>
<pre><code>UIApplication.shared.windows.forEach { window in
window.overrideUserInterfaceStyle = .dark
}
</code></pre>
<p>changing user to light mode</p>
<pre><code>UIApplication.shared.windows.forEach { window in
window.overrideUserInterfaceStyle = .light
}
</code></pre>

