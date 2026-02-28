# Rork Prototype Prompt — Dawny

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

**Character animations (CSS/Animated API — no Lottie needed for prototype):**
- Sleep: slow vertical breathing bob (up 4px, down 4px, 3s loop); "zZz" text floats upward and fades
- Almost: same bob but slightly faster; single eye blinks open occasionally
- Wake: small joyful bounce (scale 1.0 → 1.05 → 1.0, 0.8s loop)

**Parent access:**
- Triple-tap anywhere on the top-right quadrant of the screen
- Shows a PIN entry modal (4 large digit circles, number pad below)
- Default PIN: "1234" for prototype
- On correct PIN: slides up the Parent Quick Menu

---

### 3. Parent Quick Menu (modal sheet, slides up from bottom)

Appears over the clock screen after PIN entry. Dark semi-transparent backdrop.

Contents:
- Handle bar at top (standard sheet indicator)
- Row: current child name + character emoji
- Row: "Wake time today" — shows time + two buttons: `−15 min` and `+15 min` (adjusts wake time for today only)
- Row: "Next transition" — e.g., "Green in 6h 42m"
- Divider
- Button: "Settings" (full-width, secondary style) → opens Settings screen
- Button: "Exit Dawny" (text link, red, small) → exits clock mode

---

### 4. Settings Screen

Standard iOS-style settings list. White background `#FFFFFF`, grouped sections.

**Section: Child Profile**
- Child name (tappable → edit text field)
- Character (tappable → character picker, same UI as onboarding step 3)

**Section: Schedule**
- Bedtime (tappable → time picker wheel)
- Wake time (tappable → time picker wheel)
- Almost-time warning (tappable → segmented: 5 / 10 / 15 / 30 min)
- Weekends (toggle — when ON, shows separate Weekend wake time picker)

**Section: Display**
- Show clock on screen (toggle, default OFF)

**Section: Parent Lock**
- Change PIN (tappable → 2-step: enter current PIN, enter new PIN)

**Section: Preview**
- "Preview all stages" button → immediately cycles through Sleep → Almost → Wake on the clock face (3 seconds each), then returns to idle

**Section: About**
- Version number
- "From the makers of Wakey Wakey"

---

## State management

Use a single global store (Zustand or React Context) with this shape:

```typescript
interface AppState {
  // Profile
  childName: string;           // "Olivia"
  characterId: string;         // 'sunny' | 'luna' | 'pip' | 'dino' | 'bear'

  // Schedule
  sleepTime: { hour: number; minute: number };    // 19:30
  wakeTime: { hour: number; minute: number };     // 7:00
  almostWindowMinutes: number;                    // 15
  weekendWakeTime: { hour: number; minute: number } | null;
  weekendsEnabled: boolean;

  // Display
  showClockFace: boolean;
  parentPin: string;           // '1234'
  onboardingComplete: boolean;

  // Clock state (derived)
  currentStage: 'sleep' | 'almost' | 'wake' | 'idle';
  nextTransitionAt: Date | null;
}
```

**Stage calculation logic (pure function):**
```typescript
function getStage(now: Date, sleepTime, wakeTime, almostWindowMinutes): Stage {
  const nowMins = now.getHours() * 60 + now.getMinutes();
  const wakeMins = wakeTime.hour * 60 + wakeTime.minute;
  const sleepMins = sleepTime.hour * 60 + sleepTime.minute;
  const almostMins = wakeMins - almostWindowMinutes;

  // Between almostTime and wakeTime → 'almost'
  if (nowMins >= almostMins && nowMins < wakeMins) return 'almost';
  // After wakeTime and before sleepTime (daytime idle) → 'wake' for 30 min then 'idle'
  if (nowMins >= wakeMins && nowMins < wakeMins + 30) return 'wake';
  // After sleepTime → 'sleep'
  if (nowMins >= sleepMins || nowMins < almostMins) return 'sleep';
  return 'idle';
}
```

Recalculate stage every 30 seconds using `setInterval`.

---

## Navigation structure

```
Stack Navigator (no header)
├── /onboarding   (shown if onboardingComplete === false)
│   ├── Step1Welcome
│   ├── Step2Schedule
│   └── Step3Character
├── /clock        (default root when onboardingComplete === true)
│   └── ParentQuickMenu (modal overlay)
└── /settings     (pushed from ParentQuickMenu)
```

---

## Character rendering (no external assets needed)

Draw all characters using React Native SVG (`react-native-svg`). Simple geometric shapes only — circles, ellipses, rounded rects. Each character is a functional component that accepts a `stage` prop and adjusts its expression.

Example — Sunny in Wake stage:
```
Large yellow circle (body)
8 short rounded lines radiating outward (rays) — slightly rotated in Wake stage
Two filled circles (eyes) — open and curved upward in Wake, closed lines in Sleep
Curved path (smile) — wide U in Wake, neutral line in Sleep
```

Bear example:
```
Large brown circle (head)
Two smaller circles top-left and top-right (ears)
Slightly lighter oval (muzzle)
Two small dark circles (eyes) — open/closed per stage
Small curved smile
```

All characters follow the same expression rules:
- **Sleep:** eyes = closed horizontal lines, mouth = neutral, overall slightly smaller scale
- **Almost:** eyes = half-open ovals, mouth = small O (yawn)
- **Wake:** eyes = open filled circles with highlight dot, mouth = big upward curve, scale slightly larger

---

## Visual polish details

- **Background color transitions:** Use React Native `Animated.Value` interpolating between stage colors over 1500ms with `easeInOut`. Never hard-cut.
- **Clock screen:** No safe area insets — true full-bleed. Use `StatusBar` hidden.
- **Character container:** Centered with `position: absolute`, does not reflow when stage changes.
- **Parent screens:** Use `SafeAreaView`, standard iOS-style padding (16pt horizontal).
- **Fonts:** Use system default (San Francisco) — `fontFamily: undefined`. For roundedness effect, use `fontWeight: '600'` on headings.
- **Shadows on cards:** `shadowColor: '#000', shadowOffset: {width:0, height:2}, shadowOpacity: 0.08, shadowRadius: 8`

---

## What to skip for the prototype

- Real RevenueCat / subscription paywalls — just add a "Premium" badge and a dummy "Upgrade" sheet that says "Coming soon"
- Real audio — skip entirely
- Background task scheduling — stage updates only need to work while app is foregrounded in the prototype
- Multiple child profiles — single profile only
- Naptime mode — not included

---

## App name & branding

- App name: **Dawny**
- Tagline: "The clock that tells your toddler when to wake"
- From the makers of **Wakey Wakey**
- No app icon needed for prototype; use a yellow sun emoji as placeholder

---

## Deliverable

A working Expo React Native prototype that:
1. Completes onboarding and remembers the child's name, character, and schedule
2. Shows the clock screen with correct stage color based on the current real time
3. Smoothly cross-fades between stage colors when the stage changes
4. Animates the selected character with stage-appropriate expressions
5. Allows triple-tap → PIN → Parent Quick Menu → wake time adjustment → live clock update
6. Has a fully navigable Settings screen
7. Has a working Preview mode (cycles through all 3 stages)
