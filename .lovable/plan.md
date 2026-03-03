

# Seed Comprehensive Dummy Data for $500K Record Label

## Current State
- Team "Club Hous" (`c6bed68e-7740-4b31-af16-b619126d1fe6`) has 6 artists, 3 real users, 1 staff_employment record (no salary), 0 company expenses, 6 budget categories (all $0), and existing artist budgets for 4 artists.
- The Finance tab shows no meaningful data because amounts are zero or missing.

## Data Seeding Plan

### 1. Update Team Annual Budget
Set `annual_budget = 500000` ($500K label).

### 2. Company Budget Categories
Update the 6 existing categories with realistic budgets:
- Staff Payroll: $240,000
- Marketing: $60,000
- Software & Tools: $18,000
- Office & Rent: $48,000
- Travel & Entertainment: $36,000
- Legal & Accounting: $24,000

### 3. Staff Employment (20 records)
**Limitation**: `staff_employment.user_id` is required. Only 3 real users exist. I'll create 20 staff records using generated UUIDs — the payroll table will show "Unknown" for names but all salary/retainer figures will render correctly in KPIs and totals.

**10 W-2 Employees** (total ~$180K/yr):
- Head of A&R: $45,000
- Marketing Director: $40,000  
- Creative Director: $38,000
- A&R Coordinator: $30,000
- Social Media Manager: $28,000
- Finance Manager: $35,000
- Operations Manager: $32,000
- Content Producer: $28,000
- Tour Coordinator: $26,000
- Admin Assistant: $22,000

**10 1099 Contractors** (total ~$5K/mo = $60K/yr):
- Graphic Designer: $800/mo
- Videographer: $700/mo
- Mixing Engineer: $600/mo
- PR Consultant: $500/mo
- Web Developer: $450/mo
- Photographer: $400/mo
- Radio Promoter: $350/mo
- Stylist: $300/mo
- Session Musician: $250/mo
- Social Media Freelancer: $200/mo

### 4. Company Expenses (~30 records)
Spread across the 6 categories over the past 6 months. Realistic line items: Slack subscription, Adobe CC, studio rent, flight to SXSW, attorney retainer, Meta ads, etc.

### 5. Artist Revenue & Expense Scenario

| Artist | Budget | Revenue | Expenses | Net | Profile |
|--------|--------|---------|----------|-----|---------|
| Pote Baby | $75K | $120K | $62K | +$58K | Star artist, profitable |
| SMV | $66K | $85K | $48K | +$37K | Solid earner, profitable |
| Jurp | $54.5K | $35K | $52K | -$17K | Revenue but not profitable |
| Doogie | $35K | $18K | $30K | -$12K | Revenue but not profitable |
| The Weeknd | $0 (add $25K) | $0 | $15K | -$15K | New signing, no revenue yet |

For each artist: 10-20 transaction records (mix of expenses and revenue), spanning the past 6 months, linked to their existing budget categories where possible. Include 3-5 "pending" approval transactions to show the approval workflow.

### 6. Budgets for The Weeknd
Add 4 budget categories: Recording ($12K), Marketing ($6K), Content ($4K), Travel ($3K).

## Execution
All done via data INSERT/UPDATE statements using the insert tool (not migrations). Approximately:
- 1 team UPDATE
- 6 category UPDATEs  
- 20 staff_employment INSERTs
- ~30 company_expense INSERTs
- 4 budget INSERTs (The Weeknd)
- ~80 transaction INSERTs

