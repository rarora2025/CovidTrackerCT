---


---

<p>just replace tblView with the name of your table view</p>
<pre><code>func  animateTable(){

tblView.reloadData()

let cells = tblView.visibleCells

let tblViewHeight = tblView.bounds.size.height

for cell in cells {

cell.transform = CGAffineTransform(translationX: 0, y: tblViewHeight)

}

var delayCounter = 0

for cell in cells {

UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {

cell.transform = CGAffineTransform.identity

}, completion: nil)

delayCounter += 1

}

}
</code></pre>

