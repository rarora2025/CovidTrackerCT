---


---

<p>to push to the view controller- townviewcontroller, for example:</p>
<pre><code>let VC = self.storyboard?.instantiateViewController(withIdentifier: "TownViewController") as? TownViewController

self.navigationController?.pushViewController(VC!, animated: true)
</code></pre>

