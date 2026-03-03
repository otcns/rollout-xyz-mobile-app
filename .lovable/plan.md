
# Settings Restructure + Notifications + Weekly Digest Widget

## 1. Role-Aware Settings Tabs

Modify `src/pages/Settings.tsx` to show different tabs based on the user's team role:

- Import `useTeams` and `useSelectedTeam` hooks
- Derive `myRole` from the current team membership
- **Owners/Managers** see 3 tabs: "Profile", "Notifications", "Team Settings"
- **All other roles** (artist, guest) see 2 tabs: "Profile", "Notifications"
- Change `SettingsSection` type to `"profile" | "notifications" | "team"`
- When `activeSection === "team"`, render two sub-pills inside: "Members" and "Team Profile", tracked via local `teamSubSection` state
- Render `<TeamManagement showSection="members" />` or `<TeamManagement showSection="profile" />` accordingly

## 2. Notification Settings Component

Create `src/components/settings/NotificationSettings.tsx`:

- Query `notification_preferences` for current user on mount
- Display user info header (avatar, name, email) at the top
- Render 4 notification cards, each as a row with title + description on the left, Email and SMS Switch toggles on the right:

| Card | Description | DB Columns |
|------|-------------|------------|
| Tasks | When a task is assigned to you | `task_assigned_email`, `task_assigned_sms` |
| Task Due Soon | 24 hours before a task is due | `task_due_soon_email`, `task_due_soon_sms` |
| Task Overdue | When a task passes its due date | `task_overdue_email`, `task_overdue_sms` |
| Milestone Reached | When a major milestone is completed | `milestone_email`, `milestone_sms` |

- Each toggle fires an update mutation against `notification_preferences` for the specific column
- Show a role badge at the bottom using `useTeams` data
- Weekly Summary is excluded from this page (handled by the dashboard widget)

## 3. Weekly Digest Dashboard Widget

Create `src/components/overview/WeeklyDigestCard.tsx`:

- Renders conditionally at the top of the Dashboard tab in `src/pages/Overview.tsx`
- Visibility conditions (all must be true):
  1. User's `weekly_summary_email` preference is enabled in `notification_preferences`
  2. Not dismissed for the current week (checked via `localStorage` key `weekly-digest-dismissed-{mondayDate}`)
- Content: summary of the past 7 days pulled from existing Overview data (tasks completed, milestones hit, budget metrics)
- Has an "X" close button that sets `localStorage` and hides the card until next Monday
- Integrate into `Overview.tsx` by rendering `<WeeklyDigestCard />` above the dashboard grid when `companyTab === "dashboard"`

## 4. Settings.tsx Tab Rendering Update

Replace the current 4-button tab bar with a dynamic tab list:

```text
const tabs = [
  { key: "profile", label: "Profile" },
  { key: "notifications", label: "Notifications" },
  ...(isOwnerOrManager ? [{ key: "team", label: "Team Settings" }] : []),
];
```

When "Team Settings" is active, render an inner sub-navigation:

```text
+----------------------------------------------+
| [Members]  [Team Profile]                    |
+----------------------------------------------+
| <TeamManagement showSection={subSection} />  |
+----------------------------------------------+
```

## Files to Create
- `src/components/settings/NotificationSettings.tsx`
- `src/components/overview/WeeklyDigestCard.tsx`

## Files to Modify
- `src/pages/Settings.tsx` -- role-based tabs, integrate NotificationSettings, team sub-sections
- `src/pages/Overview.tsx` -- render WeeklyDigestCard at top of dashboard tab
