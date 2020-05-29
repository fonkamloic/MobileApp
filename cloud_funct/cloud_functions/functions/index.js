const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().functions);

var newData;

exports.messageTrigger = functions.firestore
  .document('Messages/{messageId}')
  .onCreate((snapshot, context) => {
    if (snapshot.empty) {
      console.log('No Device');
      return;
    }
    var tokens = [
        'eiZzVfk-4xU:APA91bHzdNrKgBlDd7GXYyy_op7Ql9lyd5embJSTqf1Gmbnoe1gnzlBIhmQfgeMmOB3GqDeBpg_1Poz1beubK3N_0IwLBMzmkoJKqxhp6Mkvx0YZKYKM8SUrBdilep8kodCArhg09aKw',
    ];
    newData = snapshot.data;
    var payload = {
      notification: { title: 'Push Title', body: 'Push body', sound: 'default' },
      data: { click_action: 'FLUTTER_NOTIFICATION_CLICK', message: 'Sample Push Message' }
    };
    try{
        const response = await admin.messaging().sendToDevice(tokens, payload);
            console.log("Notification sent successfully!");
    } catch(err) {
        console.log('Error sending notification. error is ' + $err)
    }
  });

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });
