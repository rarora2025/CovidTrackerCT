---


---

<pre><code>extension  Float {

var clean: String {

return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)

}

}
</code></pre>
<p>Usage:</p>
<pre><code>   var x = 1.0
   print(x.clean) //prints 1
</code></pre>

