# Rork Prompt — Dawny

---

Build a React Native (Expo) iOS app called **Dawny** — a kids "OK-to-Wake" alarm clock. No hardware needed. A full-screen color-changing display tells toddlers when it's OK to get out of bed.

---

## Core concept

The app has two modes:
1. **Clock mode** — child-facing, full-screen colored background + friendly character. No UI chrome. Just color + character.
2. **Settings mode** — parent-facing, clean white UI for configuring schedules and profiles.

---

## Premium gating overview

Free tier delivers a complete, working experience for one child on a fixed daily schedule. Premium unlocks features that every single-child family will want after a week of use. There is no feature that only benefits multi-child families.

| Feature | Free | Premium |
|---|---|---|
| 1 child profile | ✓ | ✓ |
| Same-time-every-day schedule | ✓ | ✓ |
| 3 color stages | ✓ | ✓ |
| Sunny character | ✓ | ✓ |
| Transition chimes | ✓ | ✓ |
| Preview mode | ✓ | ✓ |
| Parent PIN lock | ✓ | ✓ |
| Weekend / per-day schedules | — | ✓ |
| Gradual sunrise wake | — | ✓ |
| All 5 characters | — | ✓ |
| Reward sticker chart | — | ✓ |
| Bedtime reminder (push notification) | — | ✓ |
| Morning routine timer | — | ✓ |
| Sleep history log | — | ✓ |
| Naptime mode | — | ✓ |
| Ambient sounds (8 tracks) | — | ✓ |
| Custom stage colors | — | ✓ |
| Multiple child profiles | — | ✓ |

---

## Screens to build

### 1. Onboarding (8 steps, shown only on first launch)

Onboarding uses a horizontal pager (no swipe — CTA buttons advance only). A thin progress bar at the top fills across all 8 steps. A "Back" chevron appears from step 2 onward. Background is warm off-white `#F7F4EF` throughout. All steps slide in from the right.

---

**Step 1 — Hook**

Full-screen hero layout. No progress bar on this step — it fades in after tapping the CTA.

- Top half: animated illustration — a phone on a nightstand, screen glowing deep navy `#1A2744`, then cross-fading to amber, then to green, then back to navy. Loops continuously. Rendered as three rounded rect SVG shapes (phone outline + screen) cross-fading their fill color. No external assets needed.
- Headline: "No more 5 AM wake-ups." — 30pt bold, centered, `#1A1A1A`
- Subtext: "Dawny teaches your toddler to wait for the green light — so everyone sleeps in." — 16pt regular, `#6B6B6B`, centered, max-width 300pt
- CTA: "How does it work?" (full-width, rounded, `#4A90D9`)
- Very small text link below button: "Skip setup" — jumps directly to Step 8 (clock screen with defaults)

---

**Step 2 — How it works (education)**

This step has no inputs. Its only job is to make the parent confident before they configure anything.

- Title: "Three colors. One rule." — 24pt bold
- Three large stage cards stacked vertically, each ~80pt tall, rounded corners, soft shadow:

  **Card 1 — Sleep**
  - Left: filled circle, color `#1A2744` (navy), diameter 36pt
  - Right: bold label "Stay in bed" + subtext "Screen glows blue all night"

  **Card 2 — Almost Time**
  - Left: filled circle, color `#F4A227` (amber), diameter 36pt
  - Right: bold label "Getting close…" + subtext "Waking up soon — stay quiet"

  **Card 3 — Wake Up!**
  - Left: filled circle, color `#4ADE80` (green), diameter 36pt
  - Right: bold label "You can get up!" + subtext "Green means GO"

- Cards animate in one at a time with a staggered fade+slide-up (0ms, 150ms, 300ms delays)
- Below cards: small italic note — "Your child sees the color. That's it. No buttons, no confusion."
- CTA: "Got it — let's set it up"

---

**Step 3 — Child's name**

Single-focus step. One field, no distraction.

- Title: "What's your child's name?" — 24pt bold
- Large text input, centered, 22pt, placeholder: "Olivia" — auto-focuses and opens keyboard on mount
- Below input: small label "You can add more children later" — `#6B6B6B`, 13pt
- CTA: "Next" — disabled (gray) until at least 1 character is typed; enabled (blue) once name is entered
- Keyboard: `.namePhonePad` return key "Next" advances to Step 4

---

**Step 4 — Choose a character**

- Title: "Pick [child name]'s character" (uses name from Step 3) — 24pt bold
- Subtext: "They'll see this on screen every night" — 14pt, `#6B6B6B`
- 2×3 grid of character cards (last cell empty), each ~140pt square, rounded corners 16pt, soft shadow:
  1. **Sunny** — SVG sun character in Wake expression (smiling) — "FREE" green pill badge bottom-right
  2. **Luna** — SVG moon character in Wake expression — gold lock icon top-right corner
  3. **Pip** — SVG bird character in Wake expression — gold lock icon
  4. **Dino** — SVG dinosaur character in Wake expression — gold lock icon
  5. **Bear** — SVG bear character in Wake expression — gold lock icon
- Selected card: blue border ring 3pt, slight scale-up (1.03) spring animation
- Default selected: Sunny
- Tapping a locked character: card shakes (horizontal spring wiggle), shows a small tooltip bubble above it: "Premium character — unlock with free trial" with a "Learn more" link that opens Paywall Sheet as a sheet (not replacing onboarding)
- CTA: "Next"

---

**Step 5 — Bedtime**

- Title: "When does [child name] go to bed?" — 24pt bold
- Large iOS wheel time picker, centered — default 7:30 PM
- Below picker: small contextual label that updates live as the wheel turns:
  - Before 6 PM: "That's quite early — make sure the room is dark!"
  - 6–8 PM: "Perfect bedtime for toddlers 👍"
  - After 9 PM: "A little late — adjust if needed"
  - Label color: `#6B6B6B`, 13pt italic
- CTA: "Next"

---

**Step 6 — Wake time**

- Title: "When should [child name] wake up?" — 24pt bold
- Large iOS wheel time picker, centered — default 7:00 AM
- Below picker: live label showing the sleep window duration:
  - e.g., if bedtime = 7:30 PM and wake = 7:00 AM → "That's 11h 30m of sleep — great for a toddler!"
  - Calculates automatically as wheel turns
  - If wake time is before bedtime by less than 6 hours → shows amber warning: "That's only [X]h — is that right?"
  - Label color: `#6B6B6B` normally; `#E8A820` for warnings; 13pt italic
- "Almost-time warning" — small collapsible section below the live label, collapsed by default:
  - Tappable row: "Almost-time warning · 15 min ›"
  - Expands to show segmented control: 5 min / 10 min / 15 min / 30 min
  - Helper text: "Screen turns amber [X] minutes before wake time as a heads-up"
- CTA: "Next"

---

**Step 7 — Set a parent PIN**

- Title: "Set a parent PIN" — 24pt bold
- Subtext: "Stops little hands from changing the settings. To open the parent menu, triple-tap the top-right corner of the clock screen." — 15pt, `#6B6B6B`
- Four large PIN digit circles (60pt diameter each), spaced horizontally, centered — fill in as digits are tapped
- Number pad below (standard 3×4 grid, large tap targets, 72pt rows):
  - Digits 1–9, then 0 center-bottom, backspace bottom-right (← icon)
  - Digits: 22pt, `#1A1A1A`, circular tap highlight on press
- Entry has two phases:
  - Phase 1: "Enter a 4-digit PIN" — fills 4 circles
  - Phase 2 (auto-advances after 4th digit): circles clear, label changes to "Confirm your PIN" — fills again
  - If confirm matches: green checkmark animates into each circle in sequence, then auto-advances to Step 8 after 600ms
  - If confirm doesn't match: circles shake horizontally (spring wiggle), clear, return to Phase 1 with label "PINs didn't match — try again"
- Small text link below pad: "Skip for now — I'll set this later" (sets PIN to null / no lock, skippable)

---

**Step 8 — Live preview**

The payoff step. Shows exactly what the child will see tonight.

- Title: "Here's what [child name] will see" — 24pt bold, centered
- Below title: a large rounded-rect "phone mockup" preview card (~280pt wide, ~420pt tall, corner radius 32pt, soft shadow). Inside it, a live mini clock face:
  - Fills the card interior completely (no bezel gap)
  - Shows the selected character centered
  - Background color cycles automatically: Sleep (3s) → Almost (2s) → Wake (3s) → repeat
  - Character expression updates with each stage
  - "zZz" floats up during Sleep, bounces during Wake
  - Color cross-fades between stages (same 1.5s animation as the real clock screen)
  - This is the real Clock Screen component, rendered inside a `View` with `transform: [{ scale: 0.55 }]` and `overflow: hidden`
- Below the preview card: three small colored dot + label rows (static):
  - 🔵 "Blue — stay in bed"
  - 🟡 "Yellow — almost time"
  - 🟢 "Green — you can get up!"
- Optional: "Enable bedtime reminder" toggle — shows only if notification permissions not yet granted; subtext: "We'll remind you to open Dawny at [sleep time]" — tapping requests `expo-notifications` permission
- CTA: "Start Dawny" (full-width, `#4A90D9`, large 56pt height) → saves all settings, marks `onboardingComplete = true`, navigates to Clock Screen with a full-screen cross-fade transition (not a slide — it should feel like the app waking up)
- Below CTA: small text "Free to use · Upgrade anytime"

---

### 2. Clock Screen (primary runtime view)

This is the most important screen. It must feel beautiful and calming.

**Layout:**
- Full-screen, edge-to-edge, no status bar, no navigation bar
- Background fills 100% of screen with stage color (animated cross-fade on transition, 1.5s ease — see Gradual Sunrise Wake for the special pre-wake transition)
- Character illustration centered, fills ~55% of screen height
- Optional time display: bottom-center, 48pt SF Pro Rounded, white at 25% opacity — shown only if enabled in settings

**Three stages with distinct backgrounds:**

| Stage | Background color | Character state |
|---|---|---|
| Sleep | `#1A2744` deep navy | Eyes closed, "zZz" text floating up slowly |
| Almost | `#7A4F1A` warm dark amber | One eye half-open, small yawn |
| Wake | `#1A4A2E` deep green | Big smile, arms raised, subtle bounce |

**Character animations (React Native Animated API):**
- Sleep: slow vertical breathing bob (up 4px, down 4px, 3s loop); "zZz" text floats upward and fades out, then repeats
- Almost: same bob but at 2s; a single eye blinks open and closed every 4s
- Wake: small joyful bounce (scale 1.0 → 1.05 → 1.0, 0.8s loop)

**Gradual sunrise wake (Premium):**
- If `sunriseWakeEnabled === true` for the active profile, the transition from Almost → Wake is not a hard cut
- Over the configured `sunriseDurationMinutes` (5 / 10 / 20 min) before wake time, the background interpolates continuously: `#7A4F1A` amber → `#3A6B3A` mid-green → `#1A4A2E` full green
- The character simultaneously cross-fades its expression from Almost to Wake over the same window
- Implemented as a continuous `Animated.Value` driven by `(now - sunriseStartTime) / sunriseDurationMs` updated every 10 seconds

**Morning routine timer (Premium):**
- After wake stage begins, if `morningRoutineMinutes > 0` for the active profile, a countdown arc appears around the character
- Arc is a circular progress ring (white, 15% opacity, strokeWidth 6) that depletes clockwise over the routine duration
- Small text below character: "19:42 left" — same white 25% opacity style as the clock
- When timer reaches zero: character does a big bounce animation (scale 1.0 → 1.15 → 1.0 spring) and a chime plays

**Nap progress arc:**
- During an active manual nap, a similar circular arc (same style as morning routine) shows time remaining
- Small label: "Nap ends in 48:00"

**Parent access:**
- Triple-tap anywhere on the top-right quadrant of the screen
- Shows a PIN entry modal (4 large digit circles, number pad below)
- Default PIN: "1234"
- On correct PIN: slides up the Parent Quick Menu

---

### 3. Parent Quick Menu (modal sheet, slides up from bottom)

Appears over the clock screen after PIN entry. Dark semi-transparent backdrop.

Contents:
- Handle bar at top
- Row: current child name + character emoji + "Switch child" link (right-aligned, blue) → opens profile switcher
- Row: "Wake time today" — shows time + `−15 min` and `+15 min` buttons (today-only override, does not change saved schedule)
- Row: "Next transition" — e.g., "Green in 6h 42m"
- Row: "Great job! ⭐" button — tapping logs a sticker for this morning (visible only during or after wake stage; Premium shows sticker animation, free shows paywall)
- Divider
- Button: "Start nap now" (visible if `isPremium === true`) → opens Naptime Screen
- Button: "Settings" (full-width, secondary style) → opens Settings screen
- Button: "Exit Dawny" (text link, red, small) → exits clock mode

---

### 4. Settings Screen

Standard iOS-style settings list. White background `#FFFFFF`, grouped sections.

**Section: Profiles**
- List of all child profiles, each row shows: character emoji + child name + schedule summary (e.g., "7:30 PM – 7:00 AM")
- Tapping a profile → opens Profile Editor
- "Add child" row at the bottom with a + icon — shows paywall if already have 1 profile and not premium

**Section: Parent Lock**
- Change PIN (tappable → 2-step: enter current PIN, enter new PIN)

**Section: Preview**
- "Preview all stages" button → cycles Sleep → Almost → Wake on the clock face (3 seconds each), then returns to live stage

**Section: Subscription**
- If free: "Dawny Premium" row with gold star → opens Paywall Sheet
- If premium: "Premium — Active" with expiry or "Trial ends [date]"

**Section: About**
- Version number
- "From the makers of Wakey Wakey"

---

### 5. Profile Editor Screen

Pushed from the profile list.

**Section: Child**
- Name (text input)
- Character (tappable → character picker grid; locked characters show paywall on tap)

**Section: Bedtime Schedule**
- Bedtime (tappable → time picker wheel)
- Wake time (tappable → time picker wheel)
- Almost-time warning (segmented: 5 / 10 / 15 / 30 min)
- "Weekend schedule" row — toggle with Premium lock icon if not subscribed; when ON reveals:
  - "Weekend wake time" (separate time picker)
  - Small label: "Weekday: 7:00 AM · Weekend: 7:45 AM"

**Section: Gradual Sunrise Wake** *(Premium)*
- Toggle: "Gradual sunrise wake" (lock icon if free)
- When ON: segmented control for sunrise window — 5 min / 10 min / 20 min
- Helper text: "Screen slowly brightens to green over [X] minutes before wake time"

**Section: Morning Routine Timer** *(Premium)*
- Toggle: "Morning routine timer" (lock icon if free)
- When ON: duration picker — Off / 10 min / 15 min / 20 min / 30 min
- Helper text: "After green, a countdown reminds your child to get ready"

**Section: Naptime** *(Premium)*
- "Add nap schedule" button (lock icon if free)
- If a nap exists: Nap start time + Nap duration (30 min / 1 hr / 1.5 hr / 2 hr / 2.5 hr / 3 hr) + Almost-time warning

**Section: Sounds**
- Transition chimes (toggle, default ON)
- Ambient sound (tappable → Sound Picker sheet)
- "Bedtime reminder" toggle *(Premium)* — push notification to this device at sleep time; lock icon if free

**Section: Danger Zone**
- "Delete profile" (red text, confirmation alert)

---

### 6. Sound Picker Sheet (modal)

List of sounds with a play/stop preview button per row:
- None (default, always free)
- Rainfall *(Premium — lock icon)*
- Ocean waves *(Premium)*
- Lullaby *(Premium)*
- White noise *(Premium)*
- Forest *(Premium)*
- River stream *(Premium)*
- Fan *(Premium)*
- Fireplace *(Premium)*

Tapping a locked sound opens the Paywall Sheet. Tapping play on a locked sound also opens Paywall Sheet.

Use `expo-av` to play a short 3-second preview clip when the user taps the play button. Auto-stop on sheet dismiss.

---

### 7. Paywall Sheet (modal)

Slides up from any locked feature. Also accessible from Settings → Subscription.

**Layout:**
- X close button top-right — always accessible
- Header: all 5 characters rendered in Wake expression in a horizontal row (SVG, small ~60pt each)
- Title: "Dawny Premium" (24pt bold)
- Subtitle: "Everything your little one needs to sleep better"
- Feature checklist:
  - ✓ Weekend & per-day schedules
  - ✓ Gradual sunrise wake
  - ✓ Reward sticker chart
  - ✓ All 5 characters
  - ✓ Bedtime reminders
  - ✓ Morning routine timer
  - ✓ Ambient sounds & sleep history
- Two subscription option cards (radio-style):
  - **Monthly** — "$3.99 / month" — "Cancel anytime"
  - **Yearly** — "$29.99 / year" — "Save 37%" — gold "Best Value" badge — **pre-selected**
- CTA: "Start 7-Day Free Trial" (full-width, `#4A90D9`)
- Fine print: "Free for 7 days, then [selected price]. Cancel anytime in App Store settings."
- Text link: "Restore purchase"

**Subscription state:**
- Tapping CTA: set `isPremium = true`, `premiumSource = 'trial'`, dismiss, show success toast: "Premium unlocked! Enjoy your 7-day free trial. ⭐"
- Restore: show brief spinner, then alert "No active subscription found" (simulated)
- No real StoreKit calls — button directly sets premium state. This is correct for a Rork prototype.

**Contextual headline:**
- Pass an optional `trigger` prop to the sheet — e.g. `trigger='character'` shows "Luna is a Premium character." above the title; `trigger='weekend'` shows "Weekend schedules are a Premium feature." This makes the paywall feel relevant rather than generic.

---

### 8. Sticker Chart Screen (Premium)

Accessible from Settings → Sticker Chart, or from a banner on the Parent Quick Menu after a "Great job!" tap.

**Layout:**
- Title: "[Child name]'s Stars" (32pt bold)
- Current streak badge: "🔥 5-day streak!" — shown if 5+ consecutive mornings logged
- This week: a row of 7 day labels (Mon–Sun) each with either a sticker (if logged) or an empty circle
- Sticker designs: star ⭐ for days 1–6, then rotating special stickers on day 7 (rocket 🚀), day 14 (rainbow 🌈), day 21 (crown 👑)
- All-time total: "47 stars total" in large bold text
- Motivational message that changes based on streak: 0 days: "Let's get started!", 1–2: "Great start!", 3–6: "Keep it up!", 7+: "You're on a roll!"
- "Clear all data" link at bottom (small, gray, confirmation alert)

If not premium: blur the screen content and show a centered paywall prompt card.

---

### 9. Sleep History Screen (Premium)

Accessible from Settings → Sleep History.

**Layout:**
- Title: "Sleep History"
- Child picker at top (segmented or dropdown if multiple profiles)
- Bar chart: last 14 days, x-axis = dates, y-axis = wake time (e.g., 6:00–8:00 AM range)
  - Each bar represents the scheduled wake time for that day
  - A dot on each bar shows the "Great job!" tap time if logged (when the parent confirmed the child waited)
  - Color: green bars for days the child waited, gray for no data
- Below chart: summary row — "Average wake: 7:08 AM · Compliance: 80%"

Use a simple custom bar chart built with React Native Views (no charting library needed — just absolutely positioned View bars with calculated heights).

If not premium: blur the screen and show paywall prompt.

---

### 10. Naptime Screen (modal)

Opened from Parent Quick Menu → "Start nap now".

- Title: "Start nap for [child name]?"
- Duration picker: 30 min / 1 hr / 1.5 hr / 2 hr / 2.5 hr / 3 hr
- "Start Nap" button → sets `activeNap` in store, clock immediately transitions to Sleep stage, sheet closes
- When a nap is active and this screen is reopened: shows countdown "Nap ends in 1:23:44" + "End Nap Early" button

---

### 11. Profile Switcher Sheet (modal)

Opened from Parent Quick Menu → "Switch child".

- Vertical list of profiles
- Each row: character SVG (40pt) + child name + schedule summary + checkmark if active
- Tapping a profile: sets it as active, dismisses, clock transitions to show new character and correct stage

---

## State management

Zustand with AsyncStorage persistence. Full store shape:

```typescript
type CharacterId = 'sunny' | 'luna' | 'pip' | 'dino' | 'bear';
type ClockStage = 'sleep' | 'almost' | 'wake' | 'idle';
type AmbientSoundId = 'none' | 'rainfall' | 'ocean' | 'lullaby' | 'whitenoise' | 'forest' | 'river' | 'fan' | 'fireplace';

interface TimeOfDay { hour: number; minute: number; }

interface NapSchedule {
  id: string;
  startTime: TimeOfDay;
  durationMinutes: number;       // 30 | 60 | 90 | 120 | 150 | 180
  almostWindowMinutes: number;
  isEnabled: boolean;
}

interface StickerEntry {
  date: string;                  // 'YYYY-MM-DD'
  loggedAt: string;              // ISO 8601 — time parent tapped "Great job!"
}

interface ChildProfile {
  id: string;
  name: string;
  characterId: CharacterId;
  // Bedtime schedule
  sleepTime: TimeOfDay;
  wakeTime: TimeOfDay;
  almostWindowMinutes: number;
  weekendsEnabled: boolean;
  weekendWakeTime: TimeOfDay | null;
  // Gradual sunrise wake
  sunriseWakeEnabled: boolean;
  sunriseDurationMinutes: 5 | 10 | 20;
  // Morning routine
  morningRoutineMinutes: 0 | 10 | 15 | 20 | 30;
  // Nap
  napSchedule: NapSchedule | null;
  // Sounds
  ambientSoundId: AmbientSoundId;
  transitionChimesEnabled: boolean;
  bedtimeReminderEnabled: boolean;
  // Display
  showClockFace: boolean;
  // Sticker data
  stickerLog: StickerEntry[];
}

interface AppState {
  profiles: ChildProfile[];
  activeProfileId: string;
  parentPin: string;
  onboardingComplete: boolean;
  isPremium: boolean;
  premiumSource: 'trial' | 'monthly' | 'yearly' | null;
  // Today-only wake time nudge (compare date to reset)
  todayWakeOverride: { profileId: string; date: string; wakeTime: TimeOfDay } | null;
  // Active manual nap
  activeNap: { profileId: string; endsAt: string } | null;

  // Actions
  addProfile: (profile: ChildProfile) => void;
  updateProfile: (id: string, updates: Partial<ChildProfile>) => void;
  deleteProfile: (id: string) => void;
  setActiveProfile: (id: string) => void;
  setParentPin: (pin: string) => void;
  setTodayWakeOverride: (profileId: string, wakeTime: TimeOfDay) => void;
  logSticker: (profileId: string) => void;
  startNap: (profileId: string, durationMinutes: number) => void;
  endNap: () => void;
  unlockPremium: (source: 'trial' | 'monthly' | 'yearly') => void;
}
```

---

## Stage calculation logic

```typescript
function getStage(
  now: Date,
  profile: ChildProfile,
  todayOverride: TimeOfDay | null,
  activeNap: { endsAt: string } | null
): ClockStage {
  // Active manual nap takes priority
  if (activeNap && new Date(activeNap.endsAt) > now) return 'sleep';

  const nowMins = now.getHours() * 60 + now.getMinutes();
  const isWeekend = [0, 6].includes(now.getDay());

  const effectiveWake = todayOverride
    ?? (isWeekend && profile.weekendsEnabled && profile.weekendWakeTime
        ? profile.weekendWakeTime
        : profile.wakeTime);

  const wakeMins   = effectiveWake.hour * 60 + effectiveWake.minute;
  const sleepMins  = profile.sleepTime.hour * 60 + profile.sleepTime.minute;
  const almostMins = wakeMins - profile.almostWindowMinutes;

  // Sunrise wake: the Almost stage starts at almostMins, same as before.
  // The visual treatment (gradual color blend) is handled in the Clock Screen
  // component, not here. Stage logic is unchanged.

  // Nap schedule
  if (profile.napSchedule?.isEnabled) {
    const nap = profile.napSchedule;
    const napStartMins  = nap.startTime.hour * 60 + nap.startTime.minute;
    const napEndMins    = napStartMins + nap.durationMinutes;
    const napAlmostMins = napEndMins - nap.almostWindowMinutes;
    if (nowMins >= napAlmostMins && nowMins < napEndMins) return 'almost';
    if (nowMins >= napStartMins  && nowMins < napAlmostMins) return 'sleep';
  }

  if (nowMins >= almostMins && nowMins < wakeMins) return 'almost';
  if (nowMins >= wakeMins   && nowMins < wakeMins + 30) return 'wake';
  // sleepMins wraps midnight (e.g. 19:30 vs 7:00 — sleep > wake)
  if (sleepMins > wakeMins) {
    if (nowMins >= sleepMins || nowMins < almostMins) return 'sleep';
  } else {
    if (nowMins >= sleepMins && nowMins < almostMins) return 'sleep';
  }
  return 'idle';
}
```

Recalculate stage every 30 seconds via `setInterval`. On stage change trigger sound and brightness effects.

---

## Gradual sunrise wake — implementation detail

When `sunriseWakeEnabled` is true, the clock component tracks a continuous `sunriseProgress` value (0–1) during the Almost stage:

```typescript
// Called every 10 seconds alongside the stage interval
function getSunriseProgress(now: Date, wakeMins: number, sunriseDurationMinutes: number): number {
  const nowMins = now.getHours() * 60 + now.getMinutes() + now.getSeconds() / 60;
  const sunriseStartMins = wakeMins - sunriseDurationMinutes;
  if (nowMins < sunriseStartMins) return 0;
  if (nowMins >= wakeMins) return 1;
  return (nowMins - sunriseStartMins) / sunriseDurationMinutes;
}
```

Interpolate background color using this progress value:
- progress 0.0: `#7A4F1A` (amber)
- progress 0.5: `#3A6B3A` (mid-green)
- progress 1.0: `#1A4A2E` (full green)

Use `Animated.Value` with `interpolate()` for smooth color transition between ticks.

---

## Audio

Use `expo-av`.

**Transition chimes:**
- `sleep → almost`: soft two-tone chime (generate a short sine wave beep or use a base64 inline audio clip)
- `any → wake`: gentle bird chirp sound
- Only plays if `transitionChimesEnabled === true`

**Ambient sound:**
- Starts looping when clock mounts in Sleep stage and `ambientSoundId !== 'none'` and `isPremium === true`
- Use a 5-second silent mp3 loop as placeholder — the player controls and state must work correctly
- Stops when stage changes away from Sleep, or when clock unmounts

**Sound picker preview:** plays a 3-second clip on play button tap, auto-stops after 3s or on sheet dismiss.

**Morning routine timer end chime:** same gentle chime as transition chimes, plays once when countdown reaches zero.

---

## Push notifications (Bedtime Reminder)

Use `expo-notifications`.

When `bedtimeReminderEnabled === true` on a profile and `isPremium === true`:
- Schedule a daily local notification at `profile.sleepTime` with body: "Time to start Dawny for [name] 🌙"
- Re-schedule (cancel + reschedule) whenever sleep time or the toggle changes
- Cancel the notification for a profile when `bedtimeReminderEnabled` is set to false or the profile is deleted
- Request notification permissions during onboarding Step 2 (after the user sets sleep time) — use `expo-notifications` `requestPermissionsAsync()`; if denied, show a small inline note "Enable notifications in Settings to get bedtime reminders"

---

## Navigation structure

```
Stack Navigator (no header)
├── /onboarding   (horizontal pager, progress bar, back chevron from step 2)
│   ├── Step1Hook
│   ├── Step2HowItWorks
│   ├── Step3ChildName
│   ├── Step4Character
│   ├── Step5Bedtime
│   ├── Step6WakeTime
│   ├── Step7PIN
│   └── Step8Preview
├── /clock
│   ├── ParentQuickMenu     (modal overlay, PIN-gated)
│   │   └── ProfileSwitcher (bottom sheet)
│   └── NaptimeScreen       (modal)
├── /settings
│   ├── ProfileList
│   ├── ProfileEditor       (pushed)
│   │   └── SoundPicker     (bottom sheet)
│   ├── StickerChart        (pushed — Premium)
│   ├── SleepHistory        (pushed — Premium)
│   └── PaywallSheet        (modal — triggered by locked features)
└── /add-profile-modal      (modal stack: Step2Schedule → Step3Character)
```

---

## Character rendering

Draw all 5 characters using `react-native-svg`. Each is a self-contained SVG component accepting `stage: ClockStage` prop.

**Sunny (sun):**
- Large circle, fill: `#F5C842`
- 8 rounded lines radiating outward, stroke: `#E8A820`, strokeWidth 8, strokeLinecap `round`
- Wake: lines rotate +15deg (spring animation)
- Sleep: two short horizontal lines (closed eyes), flat line mouth
- Almost: one half-open oval eye, small O mouth
- Wake: two filled circles + white highlight dots, wide upward curve mouth

**Luna (moon):**
- Crescent shape (circle with an overlapping circle subtracted), fill: `#C4B5E8`
- 3 small 4-point star shapes scattered around, fill: `#E8E0F5`
- Face centered on the crescent bulge; same eye/mouth rules

**Pip (bird):**
- Large circle body, fill: `#5BBFBF`
- Orange triangle beak — Wake: rotates slightly (spring)
- Two small rounded wing shapes on sides — Wake: angle upward −20deg (spring)
- Small rounded tail triangle at bottom
- Eyes follow standard rules

**Dino (dinosaur):**
- Large rounded rect body, fill: `#7BC47B`
- 4 small triangles along top (spines), fill: `#5A9E5A`
- Two short stubby arm rounded rects — Wake: rotate −40deg (spring)
- Eyes and mouth follow standard rules

**Bear (teddy bear):**
- Large circle head, fill: `#C4956A`
- Two smaller circles top-left and top-right (ears), same fill
- Small lighter inner circles on ears, fill: `#D4A882`
- Lighter oval muzzle, fill: `#D4A882`; small dark oval nose on muzzle
- Eyes and mouth follow standard rules

**All characters — expression rules:**
- Sleep: eyes = two short horizontal lines; mouth = flat line; scale 0.97
- Almost: eyes = one half-open oval, one closed line; mouth = small O; scale 1.0
- Wake: eyes = filled circles with white highlight dot; mouth = wide upward curve; scale 1.03 + bounce animation

---

## Visual polish

- **Background color transitions:** `Animated.Value` interpolating hex colors over 1500ms `easeInOut`. Never hard-cut (except Preview mode which uses 3s per stage for demo clarity).
- **Clock screen:** true full-bleed, `StatusBar` hidden.
- **Character container:** `position: absolute`, centered, does not reflow on stage change.
- **Parent screens:** `SafeAreaView`, 16pt horizontal padding, `#F7F4EF` background.
- **Card shadows:** `shadowColor: '#000', shadowOffset: {width:0, height:2}, shadowOpacity: 0.08, shadowRadius: 8`
- **Premium badge:** small pill, `background: #F5C842`, `color: #1A1A1A`, "Premium", 11pt semibold
- **Lock icon:** SF Symbol `lock.fill` or a simple SVG lock, shown inline with locked feature rows
- **Toasts:** custom component, slides down from top, auto-dismisses after 2.5s
- **Sticker pop animation:** when "Great job!" is tapped, a ⭐ emoji animates from the button position upward and fades out (scale 1 → 2, opacity 1 → 0, translateY −80pt, 600ms)

---

## App name & branding

- App name: **Dawny**
- Tagline: "The clock that tells your toddler when to wake"
- Accent: `#4A90D9`
- No app icon needed; use a yellow sun emoji as placeholder

---

## Deliverable

A fully working Expo React Native app that:
1. Completes all 8 onboarding steps with progress bar, back navigation, and all live interactions (sleep window calculator, PIN confirm, live preview card)
2. Persists all state across restarts; shows clock screen directly if `onboardingComplete === true`
3. Shows the clock screen with correct stage based on current real time
3. Smoothly cross-fades between stage colors on transition
4. Gradual sunrise wake: continuously interpolates color during Almost stage when enabled
5. Animates the selected character with stage-appropriate expressions and spring effects
6. Triple-tap → PIN → Parent Quick Menu works; wake time nudge updates clock live
7. "Great job!" tap logs a sticker, shows pop animation; sticker chart screen displays history
8. Paywall sheet unlocks premium state and gates all locked features contextually
9. All 5 characters render correctly in SVG with per-stage expressions
10. Sound picker UI works; ambient sound starts/stops with Sleep stage
11. Bedtime reminder: schedules a local notification when toggle is enabled
12. Morning routine timer: countdown arc visible on clock face after wake stage starts
13. Multiple child profiles: profile switcher works; free tier limited to 1
14. Naptime mode: scheduled nap in Profile Editor + manual nap from Parent Quick Menu
15. Sleep history screen renders bar chart from sticker log data
16. Preview mode cycles through all 3 stages with 3-second delay
