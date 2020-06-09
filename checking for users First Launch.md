---


---

<p>define defaults</p>
<pre><code>let  defaults = UserDefaults.standard
</code></pre>
<p>to check for first launch-</p>
<pre><code>if defaults.bool(forKey: "First Launch") == true{
print("already been here")

} else {

 print("First launch")
 defaults.set(true, forKey: "First Launch")

}
</code></pre>

