local user = _G.Usernames
local webhook = _G.Webhook

print("Usernames:")
if user then
    for i = 1, #user do
        print("-", user[i])
    end
else
    print("No usernames set")
end

print("Webhook:", webhook or "No webhook set")
