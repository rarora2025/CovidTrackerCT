---


---

<h2 id="sending-the-user-alerts">Sending the User Alerts</h2>
<pre><code>let alert = UIAlertController(title: "Alert Title", message: "put message here", preferredStyle: .alert)
</code></pre>
<p>to add actions-</p>
<pre><code>alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
</code></pre>
<p>present-</p>
<pre><code>self.present(alert, animated: true)
</code></pre>
<p>To handle actions: (add actions like this instead)</p>
<pre><code>alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in  print("Yay! You brought your towel!") }))
</code></pre>

