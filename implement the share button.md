---


---

<p>Share button: text, image, and url</p>
<pre><code>let firstActivityItem = "Text you want"
let secondActivityItem : NSURL = NSURL(string: "http//:urlyouwant")!
// If you want to put an image
let image : UIImage = UIImage(named: "image.jpg")!

let activityViewController : UIActivityViewController = UIActivityViewController(
    activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)

// This lines is for the popover you need to show in iPad 
activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)

// This line remove the arrow of the popover to show in iPad
activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.allZeros
activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)

// Anything you want to exclude
activityViewController.excludedActivityTypes = [
    UIActivityTypePostToWeibo,
    UIActivityTypePrint,
    UIActivityTypeAssignToContact,
    UIActivityTypeSaveToCameraRoll,
    UIActivityTypeAddToReadingList,
    UIActivityTypePostToFlickr,
    UIActivityTypePostToVimeo,
    UIActivityTypePostToTencentWeibo
]

self.presentViewController(activityViewController, animated: true, completion: nil)
</code></pre>
<p><a href="https://stackoverflow.com/questions/37938722/how-to-implement-share-button-in-swift">https://stackoverflow.com/questions/37938722/how-to-implement-share-button-in-swift</a></p>

