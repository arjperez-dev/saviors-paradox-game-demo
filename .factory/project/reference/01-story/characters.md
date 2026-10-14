# Characters (story)

- **Status:** approved 2026-09-30
- **Sources:** `VISION.md` §Vision statement, §Client constraints, §Non-goals · `premise.md` ·
  `00-game/glossary.md` §1
- **Read by:** whoever writes a character's lines or draws its contract in `03-characters/`. This file
  says who each one is in the story; how each one looks and moves is its contract.

---

## 1. Akeris, the Savior

- **Who he is:** the player; the only playable character. Determined, not heroic (`00-game/tone.md`).
- **What he knows:** his vision, the clock, that the world has days left. Nothing else. He does not
  know the spirits, the dungeon, or what his sword is.
- **What he wants:** to reach the clock and stop the end.
- **How he shows it:** he never speaks (`premise.md` §5). Everything he feels is pose and timing.
- **Look (story):** red eye streak, torn cape with holes, the sacred sword always on him.

## 2. Future Akeris

- **Who he is:** an Akeris from further along, who knows where the descent ends and wants to stop the
  Savior reaching the last floor.
- **In the demo:** in the outro (`cinematics/outro.md`), hinted by the zone 5 warning spirit, and in the intro's
  dream as a short circuit (`cinematics/intro.md`, shot 7): flashes of him, his streak battered, before the card.
  He does not fight and does not speak. `VISION.md` calls him *the Future Traveller*.
- **Look (story):** red streak (not yet corrupted), fully torn cape, a curved battered sword, very dirty.
  He must read as Akeris at a glance, and as Akeris after something terrible.

## 3. Corrupted Akeris

- **Who he is:** the Akeris who took the clock, used it and was corrupted by it. He waits on the last
  floor.
- **In the demo:** only in the intro's dream (`cinematics/intro.md`, shots 3–5): an Akeris like ours, torn by the
  dungeon, kills the Time Guardian and takes the clock from its stand; his red streak turns purple from the eye
  outward, his cape darkens, his back straightens and his outline hardens. Never named. The spirits speak of
  "the one below, who holds the clock" (`premise.md` §4).
- **Look (story):** purple streak, holds the clock.

## 4. The spirits

- **Who they are:** ancient spirits of the dungeon, older than Akeris's people's arrival. They have
  lived through every reset and remember every Akeris. Tired, patient, kind, and a little afraid
  (`00-game/tone.md` §1).
- **Anonymous.** No spirit has a name, a title or a life story the player learns. What matters is only
  what they say. The dialogue box shows no speaker name (`06-ui/`).
- **Two per zone, with two roles:**

| Role | Code name | Where | What it tells |
|---|---|---|---|
| lore spirit | `<zone>Lore` | somewhere in the zone, off the main path | the place, Akeris's people, the dungeon, the hints of §4 of the premise |
| warning spirit | `<zone>Warning` | on the way to the boss room | the boss: one hint per mechanic the player could miss, and the ability it leaves |

  `<zone>` is the zone's code name in `00-game/glossary.md` §6: `suspendedSanctuaryLore`,
  `suspendedSanctuaryWarning`… Where exactly they stand is decided by each zone's `layout.md`.
- **Look:** decided in `03-characters/spirits/`. What the story asks of it: they have **no eye streak**
  (they belong to no timeline), they are drawn fainter than the living, and nothing about them
  trembles.
- **How they talk:** `dialogue/rules.md`.

## 5. The bosses, as the story sees them

| Boss | Who it is |
|---|---|
| Golem | the sanctuary's keeper, cut from the sanctuary's own stone. It still holds things up, as the sanctuary taught it |
| Giant Bat | the blind thing that lives on the echoes of the caves |
| Skeleton | the oldest of the dead in the graveyard, who refuses to stay down |
| Giant Spider | what weaves in the rotting roots of the world above |
| Dragon | the last guard Akeris's people found for their walls; it has forgotten why it guards |

More in `zones-narrative.md`. None of them speaks.

## 6. Not in the demo

The Time Guardian (named only in this file and the glossary; in the intro's dream it appears only as a tall black
silhouette, no face, no detail, no name — `cinematics/intro.md` shot 4), the gems, and any fight with Future or
Corrupted Akeris (`VISION.md` §Non-goals).
