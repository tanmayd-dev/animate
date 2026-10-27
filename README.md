# Attempt to get coding models to animate

A single-file Three.js scene written end-to-end by coding models, as an experiment in how far
LLM-generated code can get on an open-ended creative task.

The result is **"Ahh Ke Gaa — An Animated Story"**: a 1,996-line `index.html` with a 3D scene,
camera moves, and Web Audio soundtrack — no build step, no dependencies, no assets to fetch.

## Run it

Open `index.html` in a browser, or serve the directory:

```sh
python3 -m http.server 8000
# http://localhost:8000
```

## What it is

- Three.js r128 (vendored via CDN in the HTML)
- Web Audio API for the soundtrack
- Everything — geometry, animation, timing, audio — in one file

## Why

To see what a coding model produces when asked to "make an animation" with no scaffolding: how it
structures a large single file, what it gets right, and where it falls back on clichés.

## License

MIT
