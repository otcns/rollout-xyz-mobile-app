

## Performance Plan — Web + Mobile

The plan already covers both web and mobile. Here's the breakdown:

| Optimization | Web impact | Mobile impact |
|---|---|---|
| Route code-splitting (React.lazy) | Faster initial page load — smaller JS bundle | Same benefit, even more important on slower connections |
| React Query defaults (staleTime, no refetchOnWindowFocus) | Eliminates redundant API calls and UI flicker | Same |
| Optimistic task updates | Instant feedback on toggle/save | Same |
| Scroll CSS (contain, overscroll-behavior, will-change) | Minor improvement | Major improvement — fixes laggy scrolling on iOS/Android |
| React.memo on list items | Fewer re-renders in large rosters/task lists | Same, more noticeable on lower-powered devices |

**In short: every change in the plan improves both web and mobile.** The scroll CSS changes are more noticeable on mobile, while code-splitting and query optimization have the biggest impact on web.

No changes to the plan are needed — ready to implement as-is.

