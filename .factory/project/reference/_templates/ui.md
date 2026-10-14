<!--
Template: piece of UI. One folder per piece in 06-ui/: hud/, pause-menu/, map/, dialogue/, title/…,
holding <piece>.md, its exported image (<piece>.png) and captures/ (the sandbox's scenario screenshots).
The mock is the shared, playable 06-ui/sandbox/sandbox.html, drawn in the game's pencil style; every
PNG is exported from it. List the piece in 06-ui/ui.md.

Screen positions are in a 1920×1080 reference frame and scale with the window; say how each element
anchors. Every player-visible string is a translator key with its English text. Controls come from
VISION.md, never from here. Delete these comments.
-->

# <Piece of UI>

- **Status:** draft · review · approved <YYYY-MM-DD>
- **Mock:** [`../sandbox/sandbox.html`](../sandbox/sandbox.html) · **Image:** [`<piece>.png`](<piece>.png)
- **Sources:** `VISION.md` §<sections> · `02-art-direction/ART_DIRECTION.md` §<sections>

## 1. Purpose

<One or two sentences: what the player learns or does here, and when.>

## 2. When it shows

| Opens on | Closes on | Pauses the game? | Over what |
|---|---|---|---|
| `<event or input from VISION.md>` | | | |

## 3. Layout

| Element | Anchor | Position and size (px at 1920×1080) | Contents | Data source |
|---|---|---|---|---|
| <health, shield uses, minimap…> | <top-left…> | | | `<contract: state or event>` |

## 4. States

| State | What changes | Trigger |
|---|---|---|
| <default, focused, disabled, low health, empty…> | | |

## 5. Navigation

| Input (as `VISION.md` names it) | Effect |
|---|---|
| | |

## 6. Text

| Key | English text | Where | Max length |
|---|---|---|---|
| `ui.<piece>.<element>` | | | |

## 7. Motion and sound

| Element | Animation | Duration (s) | Sound id |
|---|---|---|---|
| | nothing trembles | | `sfx.ui.<action>` |

## 8. Never

- <The likely mistakes, stated so they can be checked.>

## 9. Acceptance

1. <At 1920×1080 the layout matches `<piece>.png`.>
2. <At <other resolution> every element keeps its anchor and nothing overlaps.>
3. <…>
