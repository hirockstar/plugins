# KD Power

KD Power sells mobile spare parts, combos, repair tools and accessories from Karol Bagh, New Delhi. This plugin connects Claude to the KD Power catalog and, for shopkeepers and distributors, to their own KD Power account.

## What you can do

**Without signing in**

- Search parts by phone model, for example "Oppo F15 battery" or "Vivo Y20 folder". Part names are matched to categories automatically.
- See what a part fits, its options, warranty, price and stock.
- Browse categories and brands, and get the store's address, contact details and policies.

**With a KD Power shopkeeper or distributor account**

- See your own buying prices and exact stock.
- Place orders: pick the right item for each line, check the final table and confirm. Orders are created as pending; payment and pickup happen at the KD Power counter or on kdpower.in.
- See recent and older orders with every item and quantity, their status, and invoice links.
- Ask "is my order ready?" to read your order updates.
- Check your balance and transactions, and reorder the items you buy most.

## How it works

The plugin adds one remote MCP server, `https://kdpower.in/mcp`, and a skill that tells Claude how to search, order safely and present results as tables. Searches send your search words to KD Power. Signing in uses KD Power's own login page (OAuth); Claude never sees your password or OTP. After you approve, Claude can only act on your own account: it cannot take payments, change prices, cancel orders or see other customers' data. You can disconnect any time from your KD Power profile under **AI apps**.

Privacy policy: https://kdpower.in/privacy-policy · Terms: https://kdpower.in/terms · Support: support@kdpower.in
