---


---

<h2 id="notifications">Notifications</h2>
<pre><code>import UserNotifications
</code></pre>
<p>declare a notification</p>
<pre><code> func notification(hour: Int, minute: Int, weekday: Int, text: String){

  

let content = UNMutableNotificationContent()

content.title = "your title"

content.body = text

content.sound = UNNotificationSound.default

  

let trigger = UNCalendarNotificationTrigger(dateMatching: DateComponents(hour: hour, minute: minute, weekday: weekday), repeats: true)

  

let request = UNNotificationRequest(identifier: text, content: content, trigger: trigger)

  

UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

  

}
</code></pre>
<p>request authorization</p>
<pre><code>  let center = UNUserNotificationCenter.current()

center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in

}
</code></pre>
<p>finally, you can schedule your notifications like this</p>
<pre><code>  notification(hour: 18, minute: 00, weekday: 1, text: "The Covid Tracker has been refreshed with the newest data")
</code></pre>
<p><strong>Refresher:</strong><br>
here is my answer to this problem I solved:<br>
<a href="https://stackoverflow.com/questions/62095857/swift-process-and-notification-at-a-certain-time/62096145#62096145">https://stackoverflow.com/questions/62095857/swift-process-and-notification-at-a-certain-time/62096145#62096145</a></p>

