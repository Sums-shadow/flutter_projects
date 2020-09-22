pour les notifications
ajouter cette ligne dans le fichier manifest
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" /> //juste apres la balise ouvrante de manifeste

et ajouter ceci juste apres la balise ouveante de "application"
 <!-- for notification local -->
 <receiver android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver">
   <intent-filter>
   <action android:name="android.intent.action.BOOT_COMPLETED"></action>
   </intent-filter>
   </receiver>
  <receiver android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver" />

 <!-- for notification local -->

 n'oublier pas d'installer ce plugin 
 flutter_local_notifications: any

 puis redemarrer votre application