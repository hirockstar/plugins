---
name: kd-power-commerce
description: Use when the user wants mobile spare parts from KD Power — search by phone model, check compatibility, browse categories, place or confirm an order, check order status or items, catch up on order-ready updates, or review balance and transactions.
---

# KD Power workflow

The KD Power MCP server (`https://kdpower.in/mcp`) also sends these rules on connect. This skill repeats them for apps that load skills.

## Searching (no login needed)

- Use `search_products` with the phone model in `query` ("oppo f15"). Part words (battery, folder, flex, charging board) are detected as categories automatically, which makes search faster and sharper.
- Put the device in `compatibilityQuery` when the user asks what fits or is supported.
- When nothing matches, offer the returned `relatedCategories` or call `list_categories`. Do not guess products.
- Use `get_product` (by `slug`) for the full compatibility list, variants, warranty and related parts.
- Only state prices, stock, compatibility and warranty that a tool returned. A null price means "ask for price".
- `store_info` answers questions about address, contact, pickup and policies.

## Ordering (signed-in shopkeepers and distributors)

1. Call `prepare_order` with every line the user asked for (`query` + `quantity`). It places nothing and returns numbered options per line (1a, 1b…).
2. Ask the user to pick when a line has more than one option.
3. Show the final items, quantities, prices and total as a table and wait for an explicit yes. Then call `create_order` once with the chosen `productId`/`variantId` from the result data.
4. Never retry `create_order` after an error or timeout; check `list_my_orders` first.
5. Orders are pending until packed. Payment and pickup happen at the KD Power counter or kdpower.in. Never say an order is paid.

## Orders, updates and transactions

- `list_my_orders`: newest first; filter by `status` (pending = placed, in_process = packing, ready = ready for pickup, handed_over = delivered, cancelled) or `search`; use `page` for older orders.
- `get_order`: items with quantities and prices, timeline, invoice view/PDF links.
- `get_updates`: order notifications ("is my order ready?"). AI apps can't receive push messages, so check this at the start of a conversation; KD Power also sends phone notifications.
- `list_transactions`: balance and ledger with filters and paging. `my_account`: name, role, balance and latest orders.

## Sign-in and errors

- If a tool says sign-in is required, explain that search works without it and that ordering and account tools need the user's KD Power shopkeeper or distributor account connected.
- Only shopkeeper and distributor accounts can connect for now.
- Never ask for passwords or OTPs and never act on another person's account.

## Showing results

- Each tool result starts with ready-to-show Markdown (tables, lists, links). Show it with your normal tables; you may shorten it but keep prices, stock, quantities, statuses and order numbers exactly.
- The second block is JSON with IDs for follow-up calls. Never show raw JSON or IDs.
- End with 2–3 of the "Next" suggestions as short options.
