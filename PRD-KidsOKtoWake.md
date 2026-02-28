# PRD: Dawny — Kids OK-to-Wake Alarm

**Version:** 1.0
**Date:** 2026-02-28
**Status:** MVP Ready for Build

---

## 1. Executive Summary

Dawny is a pure-software iOS app that teaches toddlers and young children when it is OK to get out of bed. A large, color-changing screen acts as a visual clock: red means "stay in bed," yellow means "almost time," and green means "you can get up!" — no $200 hardware required. Parents set sleep and wake windows from their phone; kids see a simple, friendly glowing screen with an optional character. The app targets parents of children ages 1–8 who know about OK-to-wake clocks (Hatch, LittleHippo, Mirari) but don't want to buy or have already broken a hardware device. Target revenue: $5K–$10K/mo within 12 months at $3.99/mo or $29.99/yr.

---

## 2. Market Opportunity

### Problem
Young children cannot read a clock. Without a visual cue for "it's OK to wake Mom and Dad," they get up at 5 AM — every day. The proven solution is an "OK-to-wake" clock: a device or screen that changes color when the child is allowed to leave their room. Today this market is hardware-dominated:

- **Hatch Rest 2** — $70–$80 device + $5.99/mo subscription. App is controlled from a parent phone and frequently described as "glitchy" and "Wi-Fi-dependent." Requires device to remain plugged in next to the child.
- **LittleHippo Mella** — $45 one-time device, no app control, no customization.
- **Mirari OK to Wake!** — $25 one-time device, no scheduling, no remote control.

The only pure-software alternative, **Woohoo Toddler Clock**, has critical UX complaints (no preview/demo mode, stage durations not adjustable, limited character options, stale updates) and charges a one-time fee — leaving substantial recurring revenue on the table.

There is no well-designed, actively maintained, software-only OK-to-wake app on the App Store.

### Market Size
- ~3.6 million babies born in the US annually; target ages 1–8 = ~26M children in the US
- Hatch crossed **$140M in annual revenue** in 2024 — proving extreme parental willingness to pay for children's sleep products
- "Toddler clock" and "ok to wake clock" are evergreen search terms with low CPM
- Parents routinely pay $10–$20/mo for sleep-related apps (Hatch, Nanit, Owlet)

### Competitive Landscape

| Competitor | Type | Price | Key Weakness |
|---|---|---|---|
| Hatch Rest 2 | Hardware + App | $70 device + $5.99/mo | Requires hardware; glitchy app; Wi-Fi-dependent |
| LittleHippo Mella | Hardware | $45 one-time | No remote control, no customization, no app |
| Mirari OK to Wake! | Hardware | $25 one-time | No scheduling, manual only |
| Woohoo Toddler Clock | Software (iOS) | $2.99 one-time | No demo mode, stages not adjustable, stale, one-time pricing |
| Kids AlarmClock | Software (iOS) | Free / tiny | Brand new, minimal features, no traction |

### Revenue Validation
- Hatch at $140M proves parents pay — even for hardware
- Woohoo at $2.99 one-time with 4.6 stars = **proven demand for software, untapped recurring revenue**
- Path to $5K/mo at $3.99/mo: **1,253 paying subscribers**
- Path to $10K/mo: **2,506 subscribers** — achievable with a single viral TikTok in parenting community

---

## 3. Target Users

### Persona 1 — The Exhausted New Parent
**Name:** Lauren, 33, Teacher
**Child:** Olivia, age 2.5
**Pain points:** Olivia wakes at 5:15 AM every day and climbs into bed with Lauren and her husband. Lauren read about Hatch on a parenting forum but doesn't want to spend $80 on a device that might get thrown across the room.
**Willingness to pay:** $3.99/mo — "less than a coffee" framing resonates. Already paying for Spotify, Apple One, and a baby monitor subscription.

### Persona 2 — The Broken-Hardware Parent
**Name:** David, 40, Engineer
**Child:** Noah, age 4
**Pain points:** Their Hatch Rest stopped connecting to Wi-Fi after a firmware update. Noah still needs the visual cue or he wakes the whole house. David wants a phone-based replacement tonight.
**Willingness to pay:** $3.99/mo without hesitation — actively searching for an alternative right now.

### Persona 3 — The Multiple-Kids Parent
**Name:** Aisha, 36, Marketing Director
**Children:** Twins, age 3 and an older child, age 6
**Pain points:** Would need to buy 2–3 Hatch devices ($150–$240). An app on old iPads placed in each room solves this at a fraction of the cost.
**Willingness to pay:** $3.99/mo for unlimited child profiles — obvious value vs. $150+ in hardware.

---

## 4. MVP Feature Set

### Feature 1: Color-Stage Clock (Core)
The app's primary screen fills the entire display with a color and a friendly character. Three stages are configurable per schedule:

| Stage | Default Color | Meaning |
|---|---|---|
| Sleep | Deep blue / navy `#1A2744` | Stay in bed, it's still night |
| Almost Time | Warm amber `#F4A227` | Getting close — stay quiet |
| Wake Up! | Bright green `#4ADE80` | You can get up! |

- Parent sets:
  - **Sleep time** (when screen goes blue) — e.g., 7:30 PM
  - **Almost-Time window** — how many minutes before wake-up to show amber (5 / 10 / 15 / 30 min)
  - **Wake time** (when screen goes green) — e.g., 7:00 AM
  - **Day-of-week schedule** (different times for weekdays vs. weekends) — **Premium**
- Screen stays on (uses `UIApplication.shared.isIdleTimerDisabled = true`) while the schedule is active
- Gentle brightness: screen dims to 5% in Sleep stage, increases to 40% in Almost-Time, 80% in Wake Up
- **Free tier:** 1 schedule (same time every day), 3 color stages, 1 character (Sunny)
- **Premium:** weekend/per-day schedules, gradual sunrise wake, all characters, custom stage colors

### Feature 2: Characters
A character is displayed on the clock screen — friendly, non-scary, culturally diverse. The character changes expression per stage:

| Stage | Expression |
|---|---|
| Sleep | Eyes closed, "zZz" floating above |
| Almost Time | One eye open, yawning |
| Wake Up! | Big smile, arms raised |

**MVP character roster (5):**
1. Sunny — a friendly sun (gender-neutral)
2. Luna — a sleepy moon with stars
3. Pip — a round cartoon bird
4. Dino — a gentle dinosaur
5. Bear — a classic teddy bear

- Character displayed as large SVG/Lottie illustration centered on screen
- Subtle idle animation even in Sleep stage (slow breathing rise/fall)
- **Free tier:** Sunny only
- **Premium:** all 5 characters + 2 new characters added per quarter

### Feature 3: Sound Cues
- Optional soft sound when transitioning between stages (e.g., gentle chime at Almost Time, soft bird chirp at Wake Up)
- Volume independently adjustable from device volume
- Sleep stage: optional white noise / lullaby loop (3 built-in: rainfall, ocean, lullaby)
- **Free tier:** transition chimes only, no ambient sound
- **Premium:** full ambient sound library (8 sounds)

### Feature 4: Parent Lock / Child Mode
- When the app is in clock mode (child-facing), a PIN is required to exit or adjust settings
- PIN set by parent during onboarding (4-digit)
- Child cannot accidentally close the app or change settings
- Uses iOS Guided Access as a supplemental fallback option (surfaced in Settings with a how-to)
- "Secret tap" to access parent menu: triple-tap top-right corner → PIN prompt

### Feature 5: Multiple Profiles
- Each profile = one child / one room / one device
- Profile has: child name, character selection, schedule(s)
- On the parent's phone, a profile switcher lets them manage settings for all children
- On the child's device (e.g., old iPad), the app runs in single-profile child mode
- **Free tier:** 1 profile
- **Premium:** unlimited profiles

### Feature 6: Demo / Preview Mode
- In the settings, a "Preview" button instantly cycles through all three stage colors/characters with a 3-second delay between stages
- Solves Woohoo's #1 complaint: parents can show the child what each color means before bedtime
- No subscription required — available on free tier

### Feature 7: Naptime Mode
- A separate schedule type: "Nap" (shorter duration, daytime use)
- Same color-stage logic but scoped to a 1–3 hour nap window
- **Premium only**

### Feature 8: Gradual Sunrise Wake (Premium)
- Instead of a hard color switch at wake time, the background slowly brightens over a configurable window (5 / 10 / 20 min) before the full green
- During the gradual window: screen interpolates from deep navy through warm amber tones to full green
- Mimics a sunrise alarm — helps children wake naturally rather than from an abrupt change
- Character transitions from Sleep expression to Wake expression gradually as brightness increases
- **Premium only**

### Feature 9: Reward Sticker Chart (Premium)
- Each morning the child waits until the green light before getting up, the parent taps a "Great job!" button in the Parent Quick Menu — this logs the morning as a success
- Child profile accumulates stickers (one per successful morning)
- A sticker chart screen shows the current week and a running total
- Sticker designs rotate: stars, suns, hearts, rockets — new designs unlock as streaks grow (3-day, 7-day, 14-day)
- Parents can show this screen to the child as positive reinforcement
- **Premium only**

### Feature 10: Bedtime Reminder (Premium)
- A push notification to the parent's phone at the scheduled sleep time: "Time to start Dawny for [child name] 🌙"
- Reminds parents to place and open the device before the child goes to bed
- Toggle per child profile — on by default for Premium users
- **Premium only**

### Feature 11: Morning Routine Timer (Premium)
- After the wake stage begins, the clock screen can optionally display a countdown timer
- Parent sets the routine duration (e.g., 20 minutes to get dressed, eat breakfast)
- Screen shows the character + a simple progress arc draining around them
- When timer reaches zero: a gentle chime plays and the character waves
- Designed for school-age children (ages 5–8) who need to stay on schedule
- **Premium only**

### Feature 12: Sleep History Log (Premium)
- A simple weekly chart in the parent's settings showing what time the green stage triggered each day
- Also logs "Great job!" taps from the sticker chart to show compliance rate
- Helps parents track sleep regressions, DST adjustments, and schedule effectiveness
- Data stored locally (MMKV), never transmitted
- **Premium only**

---

## 5. Screen Map

```
App
├── Onboarding (first launch only)
│   ├── Welcome ("No hardware needed")
│   ├── Set up first child (name, age range)
│   ├── Choose character
│   ├── Set sleep time + wake time
│   ├── Set PIN (parent lock)
│   └── "Start Dawny" → Child Clock Screen
│
├── Child Clock Screen (full-screen, primary runtime view)
│   ├── Full-color background (stage-dependent)
│   ├── Character illustration (center)
│   ├── Time display (optional, toggled off by default for young kids)
│   └── Triple-tap → PIN entry → Parent Menu
│
├── Parent Menu (modal, PIN-protected)
│   ├── Child profile switcher
│   ├── Today's schedule summary
│   ├── Quick edit: wake time nudge (+/- 15 min)
│   ├── Go to Full Settings
│   └── Exit app (back to home screen)
│
├── Settings (full parent control panel)
│   ├── Profiles
│   │   ├── Profile list
│   │   └── Profile editor
│   │       ├── Child name
│   │       ├── Character selector
│   │       ├── Schedules (Bedtime / Naptime)
│   │       │   └── Schedule editor
│   │       │       ├── Sleep time
│   │       │       ├── Almost-Time window
│   │       │       ├── Wake time
│   │       │       └── Day-of-week toggles
│   │       └── Sounds (stage sounds + ambient)
│   ├── Parent Lock (change PIN)
│   ├── Display (show/hide time, screen brightness per stage)
│   ├── Preview Mode button
│   ├── Subscription (Upgrade / Manage)
│   └── About / Support
```

---

## 6. User Flow — Primary Journey

```
1. Parent downloads app, runs onboarding (5 min)
   └── Names child, picks character, sets 7:30 PM sleep / 7:00 AM wake, sets PIN

2. Every evening
   └── Parent opens app on child's device (old iPad or spare iPhone)
       └── Places device on nightstand / dresser facing child's bed
           └── App enters clock mode automatically at set sleep time → screen goes blue

3. During night / early morning
   └── Child wakes at 5:30 AM → sees blue screen → knows to stay in bed
   └── At 6:45 AM → screen turns amber → child knows it's almost time
   └── At 7:00 AM → screen turns green → child gets up happily

4. Parent adjusts wake time on weekend
   └── Triple-tap top-right → enters PIN → Parent Menu
       └── Taps wake time nudge → bumps to 7:45 AM → closes menu
           └── Clock updates instantly

5. Parent adds second child profile (Premium)
   └── Settings → Profiles → + Add Profile → repeat setup
       └── Manages both children from parent's phone
```

---

## 7. Monetization

### Free Tier
- 1 child profile
- 1 bedtime schedule (same time every day — no weekend variation)
- 3 color stages (Sleep / Almost / Wake)
- 1 character (Sunny)
- Transition chimes
- Demo / Preview mode
- Parent PIN lock

### Premium — $3.99/mo or $29.99/yr
- **Weekend & per-day schedules** — different wake time on Saturday/Sunday
- **Gradual sunrise wake** — slow color transition in the minutes before green
- **Reward sticker chart** — track successful mornings, unlock sticker designs on streaks
- **All 5 characters** + quarterly new additions
- **Bedtime reminder** — push notification to parent's phone at sleep time
- **Morning routine timer** — post-wake countdown for school-age kids
- **Sleep history log** — weekly chart of wake times and compliance
- **Naptime mode** — scheduled and manual naps
- **Ambient sound library** (8 sounds — rainfall, ocean, lullaby, white noise, and more)
- **Custom stage colors** — color picker to match the nursery
- **Multiple child profiles** — unlimited profiles for larger families
- Screen brightness control per stage

### Trial Strategy
- 7-day free Premium trial on first launch (no credit card, via StoreKit)
- Paywall triggers on: setting a weekend wake time, accessing sticker chart, selecting a non-Sunny character, accessing naptime, adding ambient sound
- Soft paywall with "Start Free Trial" + "Maybe Later" — no hard block
- Trigger copy is contextual: e.g. when tapping Luna — "Luna is a Premium character. Try Premium free for 7 days."

### Revenue Projections
| Month | Subscribers | MRR |
|---|---|---|
| 3 | 300 | $1,197 |
| 6 | 700 | $2,793 |
| 9 | 1,000 | $3,990 |
| 12 | 1,300 | $5,187 |
| 18 | 2,600 | $10,374 |

---

## 8. Tech Stack

- **Framework:** React Native with Expo SDK 52+
- **Language:** TypeScript throughout
- **Navigation:** Expo Router (file-based)
- **State management:** Zustand
- **Persistence:** MMKV (fast local storage — no cloud sync needed)
- **Scheduling / stage transitions:** `expo-task-manager` + `expo-background-fetch` to trigger stage changes reliably; fallback to `setTimeout` with `AppState` listener when app is foregrounded
- **Screen always-on:** `expo-keep-awake` (`activateKeepAwake()`) during clock mode
- **Animations:** Lottie (`lottie-react-native`) for character expressions; React Native Reanimated 3 for color cross-fades
- **Audio:** `expo-av` for ambient sounds and transition chimes
- **Subscriptions:** RevenueCat (`react-native-purchases`) for StoreKit 2
- **No backend required:** All data is local. No user accounts, no login.

---

## 9. AI Features

**None.** This is intentional — the app's value proposition is simplicity. A color that changes on a schedule requires zero ML, zero API costs, and zero privacy concerns. The character animations are pre-built Lottie files. No AI features are planned even in V2.

---

## 10. Data Models

```typescript
// A child's profile
interface ChildProfile {
  id: string;
  name: string;                           // e.g. "Olivia"
  characterId: CharacterId;               // 'sunny' | 'luna' | 'pip' | 'dino' | 'bear'
  schedules: Schedule[];
  ambientSoundId: string | null;          // null = silent
  transitionChimesEnabled: boolean;
  showTimeOnClockFace: boolean;
  createdAt: string;                      // ISO 8601
}

// A sleep or nap schedule
interface Schedule {
  id: string;
  type: 'bedtime' | 'nap';
  days: Day[];                            // ['sun','mon','tue','wed','thu','fri','sat']
  sleepTime: TimeOfDay;                   // when screen goes blue/dark
  almostTimeWindowMinutes: 5 | 10 | 15 | 30;
  wakeTime: TimeOfDay;                    // when screen goes green
  isEnabled: boolean;
}

interface TimeOfDay {
  hour: number;                           // 0–23
  minute: number;                         // 0 | 15 | 30 | 45
}

// Current display state (derived, not stored)
type ClockStage = 'sleep' | 'almost' | 'wake' | 'idle';

interface ClockState {
  stage: ClockStage;
  activeProfileId: string | null;
  nextTransitionAt: string | null;        // ISO 8601
}

// App-level settings
interface AppSettings {
  parentPin: string;                      // 4-digit string
  isPremium: boolean;
  premiumExpiresAt: string | null;
  activeProfileId: string;               // which profile is shown on clock face
  onboardingCompleted: boolean;
}

type CharacterId = 'sunny' | 'luna' | 'pip' | 'dino' | 'bear';
type Day = 'sun' | 'mon' | 'tue' | 'wed' | 'thu' | 'fri' | 'sat';
```

---

## 11. Design Direction

### Mood
Soft, friendly, reassuring — designed to be calming for a sleepy child and trust-inspiring for a parent. Not cartoonishly loud. Think "premium children's book illustration" meets "clean parenting app."

### Colors
| Role | Hex | Usage |
|---|---|---|
| Sleep background | `#1A2744` | Deep navy — signals night, calming |
| Almost-Time background | `#7A4F1A` | Warm dark amber — signals "getting close" |
| Wake background | `#1A4A2E` | Deep green — signals go time |
| UI background (parent screens) | `#F7F4EF` | Off-white, warm — parent-facing only |
| UI surface (parent screens) | `#FFFFFF` | Cards |
| Primary accent (parent UI) | `#4A90D9` | Buttons, links |
| Text primary | `#1A1A1A` | Parent screens |
| Text secondary | `#6B6B6B` | Subtitles |

> **Note:** The child-facing clock screen uses only the three stage backgrounds above. It is intentionally full-bleed color with no small UI chrome — just the character and (optionally) the time.

### Character Art Style
- Flat vector illustration, rounded shapes, no sharp edges
- Warm muted palette (not neon)
- Large enough to be seen from a child's bed (character fills ~60% of screen height)
- Lottie animations: slow and gentle — 2–3 second loops

### Typography (Parent Screens)
- **Font:** SF Pro Rounded (system font variant) — friendlier than default SF Pro
- Headings: 22pt semibold
- Body: 16pt regular
- Time display on clock face: 48pt, SF Pro Rounded, white/light at 30% opacity (subtle — not the focus)

---

## 12. Launch Strategy

### Pre-Launch (Weeks 1–4)
- Build a 30-second TikTok demo: phone on nightstand, screen goes from blue to green as time advances — caption: "no Hatch needed"
- Post in r/toddlers, r/beyondthebump, r/Parenting — "I'm building a free Hatch alternative, want early access?"
- Goal: 300 waitlist signups

### Launch Week (Week 5)
- Submit to App Store; emphasize "Designed for Children" category placement
- Product Hunt launch (Tuesday)
- Email waitlist with App Store link
- DM 10 parenting creators on TikTok/Instagram (no payment — offer free Premium lifetime)

### Post-Launch Growth Channels (Weeks 6–12)
- **TikTok organic:** "Watch my toddler actually stay in bed because of this $4 app" — authentic parent POV, 3 videos/week
- **Pinterest:** "Toddler sleep tips" boards consistently drive app downloads in the parenting niche — create 5 pins linking to App Store
- **Facebook Groups:** Parenting groups (e.g., "Toddler sleep help") are highly active — share as a recommendation, not an ad
- **Apple Search Ads:** "ok to wake clock," "toddler alarm," "kids alarm clock," "hatch alternative" — very low CPM, high intent
- **App Store optimization:** Title: "Dawny: OK to Wake Kids Clock" — hits all primary keywords

### Seasonal Spikes to Exploit
- **January:** New Year parenting resolutions
- **March:** Daylight Saving Time (DST) → massive spike in "toddler wake too early" searches every year — prepare a TikTok + Reddit post specifically for this

---

## 13. Success Metrics

| Metric | 30-Day | 90-Day | 12-Month |
|---|---|---|---|
| Downloads | 600 | 2,500 | 18,000 |
| Free → Premium conversion | 6% | 8% | 12% |
| Premium subscribers | 36 | 200 | 1,300 |
| MRR | $144 | $798 | $5,187 |
| Day-7 retention | 50% | 55% | 60% |
| Day-30 retention | 35% | 40% | 45% |
| Avg App Store rating | 4.6+ | 4.7+ | 4.7+ |

> Retention benchmarks are higher than typical apps because the use case is nightly and habitual — once a parent sets it up and it works, they use it every single night.

---

## 14. Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Screen stays-on drains device battery | High | Medium | Document recommended setup in onboarding: "plug device in before using as a clock." Use `expo-keep-awake` only during active clock hours. |
| Child figures out triple-tap PIN bypass | Low | Low | PIN re-prompt after 30 seconds of idle in parent menu. Add Face ID option (premium) as alternative. |
| Hatch releases a free software-only app | Low | High | Move fast; build brand and reviews before they notice the niche. Community moat is strong in parenting. |
| App Store rejects "Designed for Children" category due to subscription | Low | Medium | Subscription is parent-facing only; app does not serve ads or collect child data. App Store allows this pattern (Endless Alphabet, Khan Academy Kids use similar models). |
| DST edge cases break schedule | Medium | High | Test DST transitions explicitly. Store all times in local wall-clock time (not UTC); use iOS `TimeZone.current` and recalculate on `UIApplicationSignificantTimeChangeNotification`. |

---

## 15. Compliance

- **COPPA:** The app's paying user and account holder is always a parent. No data is collected from children. The clock face has no network calls, no analytics, no ads.
- **No data collection:** All profile and schedule data is stored locally with MMKV. Nothing is transmitted to any server.
- **Privacy Nutrition Label:** "Data Not Collected."
- **App Store Age Rating:** 4+ (no objectionable content; designed for children but controlled by adults).
- **"Designed for Children" guidelines:** App does not serve targeted advertising, does not use persistent identifiers for children, and does not collect personal information from children — compliant with Apple's Children's App guidelines.
- **Subscription:** Handled entirely by StoreKit 2 / Apple. No payment data touches the developer's infrastructure.
- **Screen time concerns:** Dawny displays a static color/character — not interactive content. Usage is passive (child watches the screen, not interacts with it). This is consistent with sleep-aid device use, not screen time concerns.

---

## 16. Future Roadmap

### V2 (Months 4–6 post-launch)
- **iPad layout optimization:** Side-by-side parent controls + clock preview on iPad
- **Reward sticker system:** Child earns a digital sticker for every morning they waited for green — shown on a sticker chart in the app (parent-controlled)
- **Siri Shortcut:** "Hey Siri, start Dawny for Olivia"

### V3 (Months 7–12 post-launch)
- **Android release** (React Native makes this straightforward after iOS validation)
- **Nap tracker:** Log nap start/end times and export to a simple weekly PDF for daycare
- **White noise machine mode:** Full-screen ambient sound player for nap use (replaces a separate white noise app)

### V4 (Year 2)
- **Family sharing:** One Premium subscription covers up to 6 devices via Apple Family Sharing
- **HomeKit integration:** Trigger smart lights (Philips Hue) to change color in sync with the app's stages — for households where the child's room has smart bulbs
- **Custom character upload:** Parents can use their child's favorite stuffed animal photo as the character (photo-based avatar editor)
