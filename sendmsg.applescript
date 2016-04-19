-- via http://stackoverflow.com/questions/11812184/how-to-send-an-imessage-text-with-applescript-only-in-provided-service --
on run {targetBuddyPhone, targetMessage}
    tell application "Messages"
        send targetMessage to buddy targetBuddyPhone of service "SMS"
    end tell
end run