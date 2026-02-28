# Rork Prompt — Dawny

---

Build a React Native (Expo) iOS app called **Dawny** — a kids "OK-to-Wake" alarm clock. No hardware needed. A full-screen color-changing display tells toddlers when it's OK to get out of bed.

---

## Core concept

The app has two modes:
1. **Clock mode** — child-facing, full-screen colored background + friendly character. No UI chrome. Just color + character.
2. **Settings mode** — parent-facing, clean white UI for configuring schedules and profiles.

---

## Screens to build

### 1. Onboarding (3 steps, shown only on first launch)

**Step 1 — Welcome**
- Full-screen, warm off-white background `#F7F4EF`
- Large centered text: "Meet Dawny" in SF Pro Rounded, 32pt bold
- Subtext: "The color-changing clock that teaches your toddler when it's OK to get up."
- Three small icon+label rows showing: 🔵 Sleep → 🟡 Almost time → 🟢 Time to wake!
- CTA button: "Get Started" (full-width, rounded, accent blue `#4A90D9`)

**Step 2 — Set up your child**
- Text input: "Child's name" (placeholder: "e.g. Olivia")
- Two time pickers (wheel-style):
  - "Bedtime" — default 7:30 PM
  - "Wake time" — default 7:00 AM
- Segmented control: "Almost-time warning" — 5 min / 10 min / 15 min / 30 min (default 15 min)
- CTA: "Next"

**Step 3 — Choose a character**
- Title: "Pick your character"
- Horizontal scroll row of 5 character cards (each ~120x120pt, rounded corners, soft shadow):
  1. **Sunny** — a smiling sun with round rays (yellow/orange)
  2. **Luna** — a crescent moon with small stars (soft purple/navy)
  3. **Pip** — a round cartoon bird (teal/orange beak)
  4. **Dino** — a gentle round dinosaur (sage green)
  5. **Bear** — a classic round teddy bear (warm brown)
- Selected character gets a blue ring border
- Default selection: Sunny
- CTA: "Start Dawny" → goes to Clock Screen

---

### 2. Clock Screen (primary runtime view)

This is the most important screen. It must feel beautiful and calming.

**Layout:**
- Full-screen, edge-to-edge, no status bar, no navigation bar
- Background fills 100% of screen with stage color (animated cross-fade on transition, 1.5s ease)
- Character illustration centered, fills ~55% of screen height
- Optional time display: bottom-center, 48pt SF Pro Rounded, white at 25% opacity — shown only if enabled in settings

**Three stages with distinct backgrounds:**

| Stage | Background color | Character state | Brightness |
|---|---|---|---|
| Sleep | `#1A2744` deep navy | Eyes closed, "zZz" text floating up slowly | ~10% screen brightness |
| Almost | `#7A4F1A` warm dark amber | One eye half-open, small yawn | ~40% screen brightness |
| Wake | `#1A4A2E` deep green | Big smile, arms raised, subtle bounce | ~80% screen brightness |

**Character animations (CSS/Animated API — no Lottie needed):**
- Sleep: slow vertical breathing bob (up 4px, down 4px, 3s loop); "zZz" text floats upward and fades
- Almost: same bob but slightly faster; single eye blinks open occasionally
- Wake: small joyful bounce (scale 1.0 → 1.05 → 1.0, 0.8s loop)

**Parent access:**
- Triple-tap anywhere on the top-right quadrant of the screen
- Shows a PIN entry modal (4 large digit circles, number pad below)
- Default PIN: "1234"
- On correct PIN: slides up the Parent Quick Menu

---

### 3. Parent Quick Menu (modal sheet, slides up from bottom)

Appears over the clock screen after PIN entry. Dark semi-transparent backdrop.

Contents:
- Handle bar at top (standard sheet indicator)
- Row: current child name + character emoji + "Switch child" link (right-aligned, blue) → opens profile switcher
- Row: "Wake time today" — shows time + two buttons: `−15 min` and `+15 min` (adjusts wake time for today only without changing the saved schedule)
- Row: "Next transition" — e.g., "Green in 6h 42m"
- Divider
- Button: "Settings" (full-width, secondary style) → opens Settings screen
- Button: "Exit Dawny" (text link, red, small) → exits clock mode

---

### 4. Settings Screen

Standard iOS-style settings list. White background `#FFFFFF`, grouped sections.

**Section: Profiles**
- List of all child profiles, each row shows: character emoji + child name + schedule summary (e.g., "7:30 PM – 7:00 AM")
- Tapping a profile → opens Profile Editor
- "Add child" row at the bottom with a + icon (free: shows paywall if already have 1 profile; premium: adds freely)

**Section: Parent Lock**
- Change PIN (tappable → 2-step: enter current PIN, enter new PIN)

**Section: Display**
- Show clock on screen (toggle, default OFF)

**Section: Preview**
- "Preview all stages" button → immediately cycles through Sleep → Almost → Wake on the clock face (3 seconds each), then returns to live stage

**Section: Subscription**
- If free: row showing "Dawny Premium" with a gold star icon → tapping opens the Paywall Sheet
- If premium: row showing "Premium — Active" with expiry date

**Section: About**
- Version number
- "From the makers of Wakey Wakey"

---

### 5. Profile Editor Screen

Pushed from the profile list. Shows all settings for one child.

**Section: Child**
- Name (text input)
- Character (tappable → character picker grid)

**Section: Bedtime Schedule**
- Bedtime (tappable → time picker wheel)
- Wake time (tappable → time picker wheel)
- Almost-time warning (segmented: 5 / 10 / 15 / 30 min)
- Weekday/Weekend toggle — when ON, reveals:
  - "Weekend wake time" (separate time picker)
  - Label: "e.g. 7:30 AM on weekdays, 8:00 AM on weekends"

**Section: Naptime** *(Premium only — show lock icon + "Premium" badge if not subscribed)*
- "Add nap schedule" button
- If a nap exists: Nap start time + Nap duration (30 min / 1 hr / 1.5 hr / 2 hr / 2.5 hr / 3 hr)
- Almost-time warning for nap (same segmented control)

**Section: Sounds**
- Transition chimes (toggle, default ON)
- Ambient sound (tappable → sound picker sheet — see below)

**Section: Danger Zone**
- "Delete profile" (red text, confirmation alert before deleting)

---

### 6. Sound Picker Sheet (modal)

Slides up when tapping "Ambient sound" in Profile Editor.

List of sounds with a play/stop preview button on each row:
- None (default)
- Rainfall *(Premium)*
- Ocean waves *(Premium)*
- Lullaby *(Premium)*
- White noise *(Premium)*
- Forest *(Premium)*
- River stream *(Premium)*
- Fan *(Premium)*
- Fireplace *(Premium)*

Premium sounds show a gold lock icon. Tapping a locked sound opens the Paywall Sheet instead of selecting it. Free users can only select "None."

Use `expo-av` to play a short 3-second preview loop when the user taps the play button. Stop any playing preview when the sheet dismisses.

---

### 7. Paywall Sheet (modal)

Slides up from any locked feature. Can also be opened from Settings → Subscription.

**Layout:**
- Close button (X) top-right — always visible, no forced paywall
- Header illustration: the 5 characters in a row, each in their Wake expression (smiling), rendered as SVG same as clock screen
- Title: "Dawny Premium" (24pt bold)
- Subtitle: "Everything your little one needs to sleep better"
- Feature list (checkmark rows):
  - ✓ Unlimited child profiles
  - ✓ Weekend & per-day schedules
  - ✓ Naptime mode
  - ✓ All 5 characters
  - ✓ Ambient sounds (8 built-in)
  - ✓ Custom stage colors
- Two subscription option cards (tappable, radio-style selection):
  - **Monthly** — "$3.99 / month" — subtext: "Cancel anytime"
  - **Yearly** — "$29.99 / year" — subtext: "Save 37%" — gold "Best Value" badge in top-right corner of card
- Yearly pre-selected by default
- CTA button: "Start 7-Day Free Trial" (full-width, rounded, `#4A90D9`)
- Fine print below button: "Free for 7 days, then [selected price]. Cancel anytime in App Store settings."
- Text link below fine print: "Restore purchase"

**Subscription state management:**
- Store `isPremium: boolean` and `premiumSource: 'trial' | 'monthly' | 'yearly' | null` in the global store
- Tapping "Start 7-Day Free Trial": set `isPremium = true`, `premiumSource = 'trial'`, dismiss sheet, show a success toast: "Premium unlocked! Enjoy your 7-day free trial."
- Tapping "Restore purchase": show a brief loading spinner, then show an alert "No active subscription found" (simulated)
- In the prototype, no real StoreKit calls are made — the button directly sets the premium state. This is the correct behavior for a Rork prototype.

---

### 8. Naptime Screen (accessible from Parent Quick Menu when a nap is configured)

Shortcut to start a manual nap right now without waiting for the scheduled time.

- Title: "Start nap for [child name]?"
- Shows nap duration selector (same options as Profile Editor)
- "Start Nap" button → immediately puts clock into Sleep stage and counts down the nap duration
- Progress arc or bar showing time remaining in nap
- "End Nap Early" button

---

## State management

Use Zustand with AsyncStorage persistence (`zustand/middleware` `persist`). Full store shape:

```typescript
type CharacterId = 'sunny' | 'luna' | 'pip' | 'dino' | 'bear';
type Day = 'sun' | 'mon' | 'tue' | 'wed' | 'thu' | 'fri' | 'sat';
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
  // Naptime
  napSchedule: NapSchedule | null;
  // Sounds
  ambientSoundId: AmbientSoundId;
  transitionChimesEnabled: boolean;
  // Display
  showClockFace: boolean;
}

interface AppState {
  profiles: ChildProfile[];
  activeProfileId: string;
  parentPin: string;
  onboardingComplete: boolean;
  isPremium: boolean;
  premiumSource: 'trial' | 'monthly' | 'yearly' | null;
  // Today-only wake time nudge (resets at midnight)
  todayWakeTimeOverride: { profileId: string; wakeTime: TimeOfDay } | null;
  // Active nap (manually started)
  activeNap: { profileId: string; endsAt: string } | null;  // ISO 8601

  // Actions
  addProfile: (profile: ChildProfile) => void;
  updateProfile: (id: string, updates: Partial<ChildProfile>) => void;
  deleteProfile: (id: string) => void;
  setActiveProfile: (id: string) => void;
  setParentPin: (pin: string) => void;
  setTodayWakeOverride: (profileId: string, wakeTime: TimeOfDay) => void;
  clearTodayWakeOverride: () => void;
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

  // Resolve effective wake time (today override > weekend wake > standard wake)
  const effectiveWake = todayOverride
    ?? (isWeekend && profile.weekendsEnabled && profile.weekendWakeTime
        ? profile.weekendWakeTime
        : profile.wakeTime);

  const wakeMins  = effectiveWake.hour * 60 + effectiveWake.minute;
  const sleepMins = profile.sleepTime.hour * 60 + profile.sleepTime.minute;
  const almostMins = wakeMins - profile.almostWindowMinutes;

  // Check nap schedule
  if (profile.napSchedule?.isEnabled) {
    const nap = profile.napSchedule;
    const napStartMins = nap.startTime.hour * 60 + nap.startTime.minute;
    const napEndMins   = napStartMins + nap.durationMinutes;
    const napAlmostMins = napEndMins - nap.almostWindowMinutes;
    if (nowMins >= napAlmostMins && nowMins < napEndMins) return 'almost';
    if (nowMins >= napStartMins && nowMins < napAlmostMins) return 'sleep';
  }

  if (nowMins >= almostMins && nowMins < wakeMins) return 'almost';
  if (nowMins >= wakeMins && nowMins < wakeMins + 30) return 'wake';
  // sleepMins is typically > wakeMins (e.g. 19:30 vs 7:00) — wraps midnight
  if (sleepMins > wakeMins) {
    if (nowMins >= sleepMins || nowMins < almostMins) return 'sleep';
  } else {
    if (nowMins >= sleepMins && nowMins < almostMins) return 'sleep';
  }
  return 'idle';
}
```

Recalculate stage every 30 seconds using `setInterval`. On stage change, trigger sound and brightness effects.

---

## Audio

Use `expo-av` (`Audio` from `expo-av`).

**Transition chimes:**
- On transition `sleep → almost`: play a soft two-tone chime (use a short inline base64 audio clip or generate a simple beep with `Audio.Sound.createAsync`)
- On transition `any → wake`: play a gentle bird chirp sound
- Only play if `profile.transitionChimesEnabled === true`

**Ambient sound:**
- When clock screen mounts and `profile.ambientSoundId !== 'none'` and `isPremium === true`: start looping ambient audio
- Use placeholder audio: a 5-second silent mp3 loop is fine for the prototype — the UI and controls must work correctly
- Stop ambient audio when clock screen unmounts or profile switches to a non-sleep stage (ambient only plays during Sleep stage)
- In Profile Editor, the sound picker preview plays a 3-second clip then stops automatically

---

## Multiple child profiles

**Profile switcher (accessible from Parent Quick Menu):**
- Shows as a bottom sheet with a vertical list of profiles
- Each row: character SVG (small, 40x40pt) + child name + schedule summary
- Checkmark on the active profile
- Tapping a profile: sets it as active, dismisses sheet, clock screen transitions to show that profile's character and stage

**Adding a second profile:**
- If `isPremium === false` and `profiles.length >= 1`: tapping "Add child" in Settings opens the Paywall Sheet instead of the Profile Editor
- If premium: tapping "Add child" opens onboarding Step 2 + Step 3 flow (re-used components) in a modal stack, pre-filled with defaults, saves as a new profile on completion

---

## Naptime mode

**Scheduled nap (configured in Profile Editor):**
- Works exactly like the bedtime schedule but scoped to daytime hours
- Stage transitions: Sleep (nap started) → Almost (nap almost over) → Wake (nap done)
- Nap Wake stage only lasts 15 minutes, then returns to Idle

**Manual nap (from Parent Quick Menu):**
- "Start nap now" button in Parent Quick Menu (shown only if `isPremium === true`)
- Opens Naptime Screen (see screen 8 above)
- Sets `activeNap` in store with `endsAt = now + durationMinutes`
- Clock immediately transitions to Sleep stage
- Progress shown as a circular arc around the character on the clock screen (white, 20% opacity, fills over nap duration)
- When nap ends: transition to Wake stage for 15 min, then Idle

---

## Navigation structure

```
Stack Navigator (no header)
├── /onboarding            (shown if onboardingComplete === false)
│   ├── Step1Welcome
│   ├── Step2Schedule
│   └── Step3Character
├── /clock                 (default root when onboardingComplete === true)
│   ├── ParentQuickMenu    (modal overlay, PIN-gated)
│   ├── ProfileSwitcher    (bottom sheet, opened from ParentQuickMenu)
│   └── NaptimeScreen      (modal, opened from ParentQuickMenu)
├── /settings              (pushed from ParentQuickMenu)
│   ├── ProfileList
│   ├── ProfileEditor      (pushed from ProfileList)
│   │   └── SoundPicker    (bottom sheet)
│   └── PaywallSheet       (modal, triggered by locked features)
└── /add-profile-modal     (modal stack: Step2Schedule → Step3Character)
```

---

## Character rendering

Draw all characters using `react-native-svg`. Each character is a self-contained SVG component accepting a `stage: ClockStage` prop.

**Sunny (sun):**
```
- Large circle, fill: #F5C842 (body)
- 8 rounded lines radiating outward, stroke: #E8A820, strokeWidth: 8, strokeLinecap: 'round'
  - In Wake stage: lines rotate +15deg with a spring animation
- Sleep: two short horizontal lines for closed eyes; flat line mouth
- Almost: one eye half-open oval; small 'O' path for mouth
- Wake: two filled circles + small white highlight dot for eyes; wide upward curve for mouth
```

**Luna (moon):**
```
- Crescent path (two overlapping circles, subtract), fill: #C4B5E8
- 3 small star shapes (4-point) scattered around, fill: #E8E0F5
- Face centered on the crescent bulge
- Same eye/mouth rules as above but using purple tones
```

**Pip (bird):**
```
- Large circle, fill: #5BBFBF (body)
- Two slightly smaller circles on top for eyes (white with dark pupil)
- Orange triangle for beak (rotates slightly in Wake stage)
- Two small wing shapes (rounded rect, rotated) on sides
  - In Wake stage: wings angle upward (+20deg) with spring
- Tail: a small rounded triangle at bottom
```

**Dino (dinosaur):**
```
- Large rounded rect/squircle, fill: #7BC47B (body)
- Row of 3–4 small triangles along the top (spines), fill: #5A9E5A
- Eyes and mouth follow same rules
- Small stubby arms: two short rounded rects on sides
  - In Wake stage: arms raise (rotate −40deg) with spring
```

**Bear (teddy bear):**
```
- Large circle, fill: #C4956A (head)
- Two smaller circles top-left and top-right (ears), same fill
- Small inner circles on ears, fill: #D4A882 (inner ear)
- Lighter oval (muzzle), fill: #D4A882
- Small dark oval (nose) on muzzle
- Eyes and mouth follow same rules
```

All characters: in Wake stage, apply a scale spring from 1.0 → 1.06 → 1.0 on mount.

---

## Visual polish

- **Background color transitions:** `Animated.Value` interpolating between stage hex colors over 1500ms `easeInOut`. Never hard-cut.
- **Clock screen:** No safe area insets — true full-bleed. `StatusBar` hidden, `navigationBarHidden: true`.
- **Character container:** `position: absolute`, centered, does not reflow when stage changes.
- **Parent screens:** `SafeAreaView`, 16pt horizontal padding.
- **Fonts:** system default (San Francisco). `fontWeight: '600'` on headings for roundedness effect.
- **Card shadows:** `shadowColor: '#000', shadowOffset: {width:0, height:2}, shadowOpacity: 0.08, shadowRadius: 8`
- **Premium badge:** small pill-shaped label, `background: #F5C842`, `color: #1A1A1A`, text: "Premium", 11pt semibold. Appears inline next to locked features.
- **Toasts:** use a simple custom toast component (slide down from top, auto-dismiss after 2.5s) for success/error feedback.

---

## App name & branding

- App name: **Dawny**
- Tagline: "The clock that tells your toddler when to wake"
- Accent color: `#4A90D9`
- No app icon needed; use a yellow sun emoji as placeholder

---

## Deliverable

A fully working Expo React Native app that:
1. Completes onboarding and persists all state across restarts
2. Shows the clock screen with correct stage based on current real time
3. Smoothly cross-fades between stage colors on transition
4. Animates the selected character with stage-appropriate expressions
5. Triple-tap → PIN → Parent Quick Menu → wake time nudge → live clock update
6. Profile switcher: switches character and stage live
7. Multiple child profiles: free tier limited to 1, premium allows unlimited
8. Naptime mode: scheduled nap in Profile Editor + manual nap from Parent Quick Menu, both work correctly
9. Paywall Sheet: unlocks premium state, gates locked features
10. Sound Picker: UI works, preview plays, ambient sound starts/stops with Sleep stage
11. Fully navigable Settings with Profile Editor and all sub-sections
12. Preview mode cycles through all 3 stages
