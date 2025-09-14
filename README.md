# KOHome
A Plugin for KOReader to expose Home Assistant's Assist functionality, letting you use Assist while reading.

### Why?
Say you are reading a book, and want to turn on a light, but do not want to reach for your phone to distract yourself from the amazing book you are reading. With KOHome, you can turn on that light without being distracted!

### Setup
Here is how to setup this plugin:
1. Click the green `<> Code` button on this page, and click "Download ZIP".
2. Navigate to where you downloaded the ZIP > Right click it and select "Extract".
3. Go into the extracted folder until you see a folder named `kohome.koplugin` > Enter that folder.
4. With your preferred Code editor / Text editor, open the `main.lua` file. You do not need to use a code editor, but it may make this task a bit easier.
5. Open your preferred browser, and go to your Home Assistant URL. From there, click your profile > Security, scroll down to "Long-lived access tokens" and click "Create Token". Give the token a name, click OK, and copy the token.
6. Go to Developer Tools > Actions > Set the Action to `Conversation: Process` and click the checkbox next to Agent. Select your agent (eg Google Generative AI or Home Assistant) and click "Go to YAML Mode". Then, copy the text next to `agent_id:`
7. Back in your Code / Text editor, find the following lines: <br>`local token = "LONGLIVEDACCESSTOKEN"`<br>`local url = "http://homeassistant.local:8123/api/conversation/process"` and<br>`agent_id = "conversation.google_generative_ai"`. Replace "LONGLIVEDACCESSTOKEN" with the token you copied, "http://homeassistant.local:8123" with your Home Assistant URL, and "conversation.google_generative_ai" with the "agent_id" you copied.
8. Save the file, and connect your KOReader device to your computer. Copy the `kohome.koplugin` directory from before to the `koreader/plugins` directory on your device.
9. All done! Eject your device, and KOHome should be avalible in the Tools section of KOReader.

### Notes:
- This is my first time coding in Lua aside from some Roblox Game Dev! There may be some bugs!
- This code was made with the help of AI. I DIDNT JUST COPY AND PASTE! I told it to teach me Lua and help me make this plugin.
