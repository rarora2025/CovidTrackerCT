---


---

<p>There are a few steps to perform this task</p>
<p>Retrieve the URL (from an online API)</p>
<pre><code> let url = URL(string: urlstring) //replace urlstring
</code></pre>
<ul>
<li>make sure to unwrap this URL, either force unwrap (add exclamation), or wrap in an if-let statement</li>
</ul>
<p>start a URL session and a data task (and resume/start it)-</p>
<pre><code>URLSession.shared.dataTask(with: url){(data, response, error) in
}.resume() 
</code></pre>
<p>add a do-catch statement inside of the task</p>
<pre><code>URLSession.shared.dataTask(with: url){(data, response, error) in
do {
//we will read the JSON here

}
catch {
print(error)
}

}.resume() 
</code></pre>
<p>Initialize the JSON Decoder inside the “DO”-<br>
URLSession.shared.dataTask(with: url){(data, response, error) in<br>
}.resume()<br>
add a do-catch statement inside of the task</p>
<pre><code>URLSession.shared.dataTask(with: url){(data, response, error) in
do {
let decoder = JSONDecoder()

}
catch {
print(error)
}

}.resume() 
</code></pre>
<p>Create a structure/ Parse the JSON</p>
<pre><code>   class  yourStructureName: Decodable {

let  propertyFromJSON: String?

enum  CodingKeys: String, CodingKey {

case  propertyFromJSON = "propertyFromJSON"
    
}

}
</code></pre>
<p><strong>Use this to help: <a href="https://app.quicktype.io">https://app.quicktype.io</a></strong></p>
<p>Finally , Read the File (under where you have defined your decoder):</p>
<pre><code>  let dataFromStruct = try decoder.decode(yourStructureName.self, from: data!)
   //put brackets around yourStructureName if it's an array of structures
</code></pre>
<p>previously struggled with this so here is the solved question - be sure not to run into same issue<br>
<a href="https://stackoverflow.com/questions/61798393/swift-error-keynotfoundcodingkeysstringvalue-intvalue-nil-swift-decoding/61798566?noredirect=1#comment109313142_61798566">https://stackoverflow.com/questions/61798393/swift-error-keynotfoundcodingkeysstringvalue-intvalue-nil-swift-decoding/61798566?noredirect=1#comment109313142_61798566</a></p>

