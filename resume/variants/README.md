# Legacy folder

Compilable variant entry points now live **next to** `resume.cls` so the IDE can find the class file:

| Build | Open / compile |
|-------|----------------|
| Backend (Google) | [`../backend.tex`](../backend.tex) |
| Master | [`../master.tex`](../master.tex) |
| AI | [`../ai.tex`](../ai.tex) |
| Robotics | [`../robotics.tex`](../robotics.tex) |
| Product | [`../product.tex`](../product.tex) |

```bash
cd resume
make backend   # or: make all
```

Do **not** open or build files in this folder — that caused `File resume.cls not found`.
