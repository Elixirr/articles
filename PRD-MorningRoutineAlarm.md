# PRD: Rise — Morning Routine Alarm

**Version:** 1.0
**Date:** 2026-02-27
**Status:** MVP Ready for Build

---

## 1. Executive Summary

Rise is an iOS alarm app that bridges the gap between waking up and starting your day. Unlike standard alarms that stop at the buzz, or habit-tracking apps that have no alarm integration, Rise combines a smart alarm (light-sleep phase detection via microphone) with a sequential, timed morning routine launcher. Users set their alarm once, define their morning steps (e.g., "Drink water 1 min → Meditate 10 min → Journal 5 min"), and Rise walks them through each step with per-step timers and audio cues — turning a chaotic morning into a structured ritual. Target revenue: $5K–$10K/mo within 12 months via a freemium subscription model priced at $4.99/mo or $39.99/yr.

---

## 2. Market Opportunity

### Problem
People who follow morning routine frameworks (Atomic Habits, Miracle Morning, etc.) use 2–3 separate apps to execute their morning:
1. An alarm app (Alarmy, Sleep Cycle, or native iOS clock)
2. A timer app (for routine steps)
3. A habit tracker (to log completion)

There is no single app that handles all three cohesively, creating friction at the moment willpower is lowest — right after waking up.

### Market Size
- Global sleep app market: $1.2B in 2024, growing 14.5% CAGR
- iOS users spend ~2× more than Android on apps
- "Morning routine" and "habit tracking" are consistently top App Store search terms in Health & Fitness

### Competitive Landscape

| Competitor | What They Do | Why They Fall Short |
|---|---|---|
| Alarmy | Wake-up missions (math, barcode, walking) | No routine steps after wake-up; outdated UI |
| SuperAlarm | Missions + weather briefing | Battery drain; no routine step sequencer |
| Routinery | Daily routine timer | No alarm integration whatsoever |
| Miracle Morning App | Guided morning practices | Not an alarm; requires manual launch |
| Fabulous | Habit/routine coach | No alarm; slow onboarding; expensive ($80/yr) |
| Sleep Cycle | Smart alarm | Stops at wake-up; $40/yr no monthly option |

### Revenue Validation
- Sleepzy (simple smart alarm): ~$10K/mo — proves a niche alarm app can hit target revenue
- Fabulous (routine + habits): raised $7.5M, proving users pay for structured morning guidance
- SuperAlarm: estimated $50–100K/mo revenue at similar price point
- Path to $5K/mo at $4.99/mo: **1,002 paying subscribers**

---

## 3. Target Users

### Persona 1 — The Atomic Habits Reader
**Name:** Marcus, 31, Software Engineer
**Pain points:** Has a morning routine he designed after reading Atomic Habits but has to mentally track steps every morning. Snoozes and loses 20 minutes he intended for exercise. Uses 3 apps to manage what should be one flow.
**Willingness to pay:** $4.99/mo without hesitation — already pays for Headspace, Notion, and Spotify.

### Persona 2 — The Overwhelmed Parent
**Name:** Priya, 38, Marketing Manager
**Pain points:** Has 45 minutes before the kids wake up. Wants to meditate, journal, and exercise but the morning is chaotic and she loses track of time per activity.
**Willingness to pay:** $3.99–4.99/mo — price-sensitive but pays for tools that save time.

### Persona 3 — The Fitness Optimizer
**Name:** Jake, 26, Personal Trainer
**Pain points:** 5 AM wake-up every day. Wants a structured pre-client routine (hydrate, mobility, review schedule) that starts the second the alarm goes off.
**Willingness to pay:** $4.99/mo — values efficiency tools.

---

## 4. MVP Feature Set

### Feature 1: Smart Alarm
- Set one or multiple alarms with day-of-week recurrence
- Optional **Smart Wake** mode: uses iPhone microphone to detect light sleep phase within a configurable 30-minute window before the set time (e.g., set for 7:00, may fire as early as 6:30)
- Smart Wake requires microphone permission; falls back to exact-time alarm if no light sleep detected
- Alarm sound library: 12 built-in gentle sounds (birds, chimes, piano, ocean, etc.)
- Snooze: configurable (off / 5 / 9 / 15 min) or disabled entirely
- Volume ramp: starts at 20% volume, reaches 100% over 60 seconds
- **Free tier:** 1 alarm, exact time only, 3 built-in sounds
- **Premium:** unlimited alarms, Smart Wake, full sound library, volume ramp

### Feature 2: Routine Builder
- After dismissing the alarm, the app immediately launches the routine
- Users define a sequence of steps:
  - Step name (e.g., "Drink water", "5-min stretch", "Journal")
  - Step duration (30 sec to 60 min)
  - Optional icon from a curated set
- Per-step countdown timer displayed full-screen with large text
- Audio cue (gentle chime) when each step ends; app auto-advances to next step
- User can tap "Done Early" to skip to next step or "Need More Time" to add 2 minutes
- Routine summary screen at the end: steps completed, total time, streak counter
- **Free tier:** 1 routine, max 3 steps
- **Premium:** unlimited routines, unlimited steps, step icons, custom step sounds

### Feature 3: Alarm ↔ Routine Linking
- Each alarm can be linked to a specific routine
- Weekday alarm can link to "Workday Routine" (45 min)
- Weekend alarm can link to "Easy Sunday Routine" (20 min)
- If no routine is linked, alarm dismisses normally

### Feature 4: Streak & Completion Tracking
- Daily streak: days in a row where alarm was dismissed (not snoozed) and routine was completed
- Weekly summary: % of days routine completed, average wake time, average routine duration
- Simple calendar view showing completed (green) and missed (grey) days
- **Free tier:** current streak only
- **Premium:** full history, weekly summary, calendar view

### Feature 5: Bedtime Reminder
- Optional push notification at a user-defined time (e.g., "Bedtime in 30 min")
- Reminder text is customizable
- No tracking, no microphone — simple notification only

### Feature 6: Widget
- Lock screen widget: shows next alarm time and routine name
- Home screen small widget: countdown to next alarm
- Uses WidgetKit (iOS 16+)
- **Premium only**

---

## 5. Screen Map

```
App
├── Onboarding (first launch only)
│   ├── Welcome
│   ├── Permissions (microphone, notifications)
│   └── Create First Alarm + Routine
│
├── Home Tab
│   ├── Next Alarm Card (time, routine linked, on/off toggle)
│   ├── All Alarms List
│   └── + Add Alarm → Alarm Editor
│
├── Routines Tab
│   ├── All Routines List
│   └── + Add Routine → Routine Editor
│       └── Step Editor (name, duration, icon)
│
├── History Tab (Premium)
│   ├── Streak + Calendar View
│   └── Weekly Summary
│
├── Settings Tab
│   ├── Subscription (Upgrade / Manage)
│   ├── Default Snooze Duration
│   ├── Smart Wake toggle + explainer
│   ├── Bedtime Reminder
│   └── Sound Library
│
└── Active Screens (modal, full-screen)
    ├── Alarm Firing Screen
    │   ├── Time display
    │   ├── Swipe-to-dismiss or mission (optional)
    │   └── "Start Routine" CTA
    └── Routine Runner
        ├── Step name + icon (full screen)
        ├── Countdown timer (large)
        ├── Progress bar (step X of N)
        ├── Done Early / Need More Time buttons
        └── Completion Screen (streak, summary)
```

---

## 6. User Flow — Primary Journey

```
1. First launch
   └── Onboarding: grant mic + notification permissions
       └── Create alarm (time, days) + create first routine (3 steps)

2. Every evening
   └── (Optional) Bedtime reminder push notification fires

3. Morning — Alarm fires
   └── Alarm Firing Screen appears (full-screen, over lock screen)
       └── User swipes to dismiss
           └── Routine Runner launches immediately (no navigation needed)
               ├── Step 1 countdown → chime → Step 2 → ... → Step N
               └── Completion screen: streak updated, "Great morning!" summary

4. Weekly check-in
   └── User opens History tab to review streak + weekly completion rate
```

---

## 7. Monetization

### Free Tier
- 1 alarm (exact time, no Smart Wake)
- 3 built-in sounds
- 1 routine, max 3 steps
- Current streak visible
- Bedtime reminder

### Premium — $4.99/mo or $39.99/yr
- Unlimited alarms
- Smart Wake (light sleep phase detection)
- Full sound library (12 sounds + more added quarterly)
- Volume ramp
- Unlimited routines, unlimited steps
- Step icons + custom step sounds
- Full history + weekly summary + calendar
- Home screen + lock screen widgets

### Trial Strategy
- 7-day free Premium trial on first launch (no credit card required via StoreKit)
- Paywall appears on: adding a 2nd alarm, adding a 4th routine step, accessing history
- Soft paywall (modal with "Start Free Trial" + "Maybe Later") — no hard block

### Revenue Projections
| Month | Subscribers | MRR |
|---|---|---|
| 3 | 200 | $996 |
| 6 | 500 | $2,495 |
| 9 | 800 | $3,992 |
| 12 | 1,100 | $5,489 |
| 18 | 2,200 | $10,978 |

---

## 8. Tech Stack

- **Framework:** React Native with Expo SDK 52+ (allows web preview on Rork)
- **Language:** TypeScript throughout
- **Navigation:** Expo Router (file-based)
- **State management:** Zustand (lightweight, no boilerplate)
- **Persistence:** MMKV (fast key-value store for alarm/routine data)
- **Notifications:** `expo-notifications` for alarm scheduling and bedtime reminder
- **Audio:** `expo-av` for alarm sounds and step chimes
- **Microphone / Smart Wake:** `expo-audio` + Web Audio API FFT for breathing pattern detection
- **Subscriptions:** `react-native-purchases` (RevenueCat) for StoreKit 2 integration
- **Widgets:** Swift native Widget Extension (separate Xcode target) communicating via App Groups
- **Animations:** React Native Reanimated 3 for countdown ring and transitions
- **Background tasks:** `expo-task-manager` + `expo-background-fetch` for alarm reliability

---

## 9. AI Features

**None in MVP.** The "Smart Wake" feature uses classical signal processing (FFT analysis of microphone input to detect breathing rate and movement sounds) — not a language model or neural network. This keeps the app lightweight, offline-capable, and free from API costs. Smart Wake accuracy improves with user-specific calibration stored locally.

---

## 10. Data Models

```typescript
// Core alarm entity
interface Alarm {
  id: string;
  label: string;
  time: { hour: number; minute: number };     // 24h
  days: Day[];                                 // ['mon','tue','wed','thu','fri']
  isEnabled: boolean;
  smartWakeEnabled: boolean;
  smartWakeWindowMinutes: 10 | 20 | 30;
  soundId: string;
  snoozeMinutes: 0 | 5 | 9 | 15;
  volumeRampEnabled: boolean;
  linkedRoutineId: string | null;
  createdAt: string;                           // ISO 8601
}

// Morning routine
interface Routine {
  id: string;
  name: string;
  steps: RoutineStep[];
  createdAt: string;
}

interface RoutineStep {
  id: string;
  name: string;
  durationSeconds: number;
  iconKey: string | null;                      // key into icon library
  soundId: string | null;                      // override per-step sound
}

// Completion record (one per day)
interface DayRecord {
  date: string;                                // 'YYYY-MM-DD'
  alarmFiredAt: string | null;                 // ISO 8601
  alarmDismissedAt: string | null;
  snoozedCount: number;
  routineId: string | null;
  stepsCompleted: number;
  stepsTotal: number;
  routineCompleted: boolean;
}

// User preferences
interface UserPrefs {
  bedtimeReminderEnabled: boolean;
  bedtimeReminderTime: { hour: number; minute: number } | null;
  isPremium: boolean;
  premiumExpiresAt: string | null;
  streakCurrentDays: number;
  streakLastCompletedDate: string | null;
}
```

---

## 11. Design Direction

### Mood
Calm, focused, premium — not gamified or aggressive. Inspired by Linear and Notion's design language: dark mode first, generous whitespace, purposeful motion.

### Colors
| Role | Hex | Usage |
|---|---|---|
| Background | `#0E0F11` | App background |
| Surface | `#1A1B1F` | Cards, modals |
| Surface Raised | `#252629` | Input fields, list rows |
| Primary Accent | `#F4D58D` | CTAs, active states, countdown ring |
| Secondary Accent | `#6B8CFF` | Smart Wake indicator, premium badge |
| Success | `#4ADE80` | Completion screen, streak |
| Text Primary | `#F0F0F0` | Headings, labels |
| Text Secondary | `#8A8A8F` | Subtitles, inactive |
| Destructive | `#FF6B6B` | Delete actions |

### Typography
- **Font:** SF Pro (system default on iOS) — no custom font needed in MVP
- Alarm time display: 72pt, semibold
- Step name in Routine Runner: 36pt, medium
- Countdown timer: 64pt, monospaced (`SF Pro Mono`)
- Body: 16pt regular

### Components
- Cards: 16px border radius, subtle `1px` border at `#252629`
- Buttons: pill shape (24px radius), 52px height
- Countdown ring: circular progress indicator built with SVG + Reanimated
- Transitions: fade + subtle scale (200ms ease-out) between routine steps

---

## 12. Launch Strategy

### Pre-Launch (Weeks 1–4)
- Build waitlist landing page (one-page, no framework needed)
- Post in r/morningroutine, r/productivity, r/atomichabits — "building an alarm that launches your morning routine, want beta testers"
- TikTok: 3 videos per week — "my morning routine app doesn't exist yet, so I'm building it"
- Goal: 500 waitlist signups before App Store launch

### Launch Week (Week 5)
- Submit to App Store (allow 1 week for review)
- Product Hunt launch on a Tuesday
- Email waitlist with TestFlight beta → App Store link
- DM 10 morning routine creators on Instagram/TikTok for organic coverage (no pay — just gifted Premium)

### Post-Launch (Weeks 6–12)
- **TikTok organic:** "morning routine with me" format showing app in use — 3 videos/week
- **Reddit:** weekly presence in r/productivity, r/selfimprovement, r/sleep
- **Apple Search Ads:** target keywords "morning routine app," "alarm clock app," "habit alarm" — budget $5/day to start
- **Review solicitation:** prompt for review on Completion screen after 7-day streak

### Content Strategy
- One YouTube video: "I combined an alarm clock with a routine timer — here's why"
- Weekly newsletter: short tips on morning routine optimization (builds email list for future products)

---

## 13. Success Metrics

| Metric | 30-Day Target | 90-Day Target | 12-Month Target |
|---|---|---|---|
| Downloads | 500 | 2,000 | 15,000 |
| Free → Premium conversion | 5% | 7% | 10% |
| Premium subscribers | 25 | 140 | 1,100 |
| MRR | $125 | $699 | $5,489 |
| Day-7 retention | 35% | 40% | 45% |
| Day-30 retention | 20% | 25% | 30% |
| Avg App Store rating | 4.5+ | 4.6+ | 4.7+ |
| Routine completion rate (D7 users) | 60% | 65% | 70% |

---

## 14. Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| iOS kills background alarm process | Medium | High | Use `UNUserNotificationCenter` (system-level) for alarm scheduling — not background app process |
| Smart Wake accuracy disappoints users | Medium | Medium | Default to exact-time alarm; Smart Wake is opt-in with clear "lab feature" framing |
| Low App Store visibility (new app) | High | High | ASO-optimize title/subtitle day 1; start Apple Search Ads at launch |
| Users don't convert from free to paid | Medium | High | Paywall at natural value moments (4th routine step), not arbitrary caps |
| SuperAlarm adds routine step feature | Low | Medium | Move fast; build community and brand before they notice the niche |

---

## 15. Compliance

- **Privacy:** No data leaves the device. Microphone audio is processed locally in real-time and never stored or transmitted. No analytics SDK that collects PII.
- **Privacy Nutrition Label (App Store):** "Data Not Collected" — no tracking, no third-party analytics.
- **Microphone permission:** Required only for Smart Wake. App functions fully without it. Permission prompt explains exactly why: "To detect your lightest sleep phase."
- **Notification permission:** Required for alarm to fire. Hard block if denied — show clear explanation with Settings deep-link.
- **GDPR/CCPA:** All data is local (MMKV on device). No account creation required. Subscription handled by Apple (StoreKit 2) — no PII stored by developer.
- **App Store guidelines:** No user-generated content, no social features, no third-party login — minimal review risk. Smart Wake microphone usage must be justified in App Review notes.

---

## 16. Future Roadmap

### V2 (Months 4–6 post-launch)
- **Shared routines:** Export/import routine templates (e.g., "Miracle Morning template," "5AM Club template")
- **Apple Health integration:** Log wake time and sleep duration to Apple Health
- **Siri Shortcut:** "Hey Siri, start my morning routine"

### V3 (Months 7–12 post-launch)
- **Apple Watch companion:** Haptic alarm on watch + view routine steps on wrist
- **Accountability partner:** Share streak with a friend via iMessage (read-only, no social feed)
- **Sleep Coach:** Optional 5-question sleep hygiene quiz with personalized suggestions (not AI — rule-based)

### V4 (Year 2)
- **Android launch** (React Native makes this low-lift after iOS validation)
- **Team/family routines:** Multiple profiles on one device (premium)
- **Integration with Shortcuts app:** Trigger HomeKit scenes at routine step start (e.g., turn on lights at "Get up" step)
