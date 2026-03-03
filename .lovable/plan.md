

## Split Sheet Wizard Redesign

### Problem
The current flow requires too many discrete steps: click "Add Release" → type name + select type → create → then separately add songs one by one → then separately add contributors one by one per song. Each step feels like starting over.

### New Flow: Inline Step-by-Step Wizard

The wizard replaces the current "new project" form and expands inline within the Splits tab (no new page). It progresses through steps with Enter/Continue, collapsing completed steps above.

```text
┌─────────────────────────────────────────────────┐
│  Step 1: Release Type                           │
│  [ Single ]  [ EP ]  [ Album ]                  │
│  (three buttons, click to select & advance)     │
├─────────────────────────────────────────────────┤
│  Step 2: Release Name                           │
│  [ Love Gun II            ]  (auto-focus, Enter)│
├─────────────────────────────────────────────────┤
│  Step 3: Song Titles                            │
│  Defaults: 1 for Single, 7 for EP, 12 for Album│
│  1. [ Track title... ] ←auto-focus              │
│  2. [ Track title... ]                          │
│  ...                                            │
│  + Add another track                            │
│  [ Continue → ]                                 │
├─────────────────────────────────────────────────┤
│  Step 4: Contributors (song-by-song)            │
│  ┌ Song 1: "Track Title" ─────────────────────┐ │
│  │ Producer: [ name... ] (autocomplete)       │ │
│  │   ☑ Track 1  ☐ Track 2  ☐ Track 3  ...    │ │
│  │   [ % ] optional inline                    │ │
│  │ + Add another producer                     │ │
│  │                                            │ │
│  │ Writer: [ name... ]                        │ │
│  │   ☑ Track 1  ☐ Track 2  ...               │ │
│  │   [ % ] optional                           │ │
│  │ + Add another writer                       │ │
│  │                                            │ │
│  │ Performer: [ name... ]                     │ │
│  │ + Add another performer                    │ │
│  │                                            │ │
│  │ [ Next Song → ]                            │ │
│  └────────────────────────────────────────────┘ │
│  (repeat for each song, pre-filling carry-over) │
├─────────────────────────────────────────────────┤
│  Step 5: Review & Save                          │
│  Summary card showing all songs + contributors  │
│  [ Create Split Sheet ]                         │
└─────────────────────────────────────────────────┘
```

### Key UX Details

1. **Step 1 (Release Type)**: Three large-ish buttons. Clicking one immediately advances to Step 2. No separate "Next" button.

2. **Step 2 (Release Name)**: Single auto-focused input. Press Enter to advance. Placeholder: "Name this release..."

3. **Step 3 (Song Titles)**: Pre-populated empty inputs based on type (1/7/12). Tab or Enter moves to next input. "+ Add another track" appends more. Empty titles are stripped on Continue. At least 1 required.

4. **Step 4 (Contributors per song)**: Song-by-song with three role sections (Producer, Writer, Performer). For each:
   - Type a name → autocomplete from saved `split_contributors` table
   - After entering a name, checkboxes appear showing all other song titles so you can quickly assign the same person to multiple tracks
   - Optional inline `%` field next to each name (not required)
   - "+ Add another [role]" to add multiple producers/writers/performers
   - "Next Song →" advances. If a contributor was assigned to Song 2 via checkboxes from Song 1, they appear pre-filled on Song 2
   - New names are auto-saved to `split_contributors` for future autocomplete

5. **Step 5 (Review)**: Quick summary table. Click "Create Split Sheet" to batch-insert the project, songs, and entries.

### Technical Plan

**New component**: `src/components/artist/SplitWizard.tsx`
- Multi-step state machine with `step` state (1-5)
- Local state accumulates all data before a single batch save
- On final submit: create project → create songs → create contributors (if new) → create entries

**Modified files**:
- `SplitsTab.tsx`: Replace inline form with `<SplitWizard>` when `showNew` is true
- `useSplits.ts`: Add a `useCreateSplitBatch` mutation that inserts project + songs + entries in sequence

**Contributor autocomplete**: Already works via `split_contributors` table. The wizard will use `useSplitContributors(teamId)` for suggestions as the user types, and auto-insert new names.

**No database changes needed** — the existing `split_projects`, `split_songs`, `split_entries`, and `split_contributors` tables support this flow as-is.

