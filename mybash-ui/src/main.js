import { invoke } from "@tauri-apps/api";

document.addEventListener("DOMContentLoaded", () => {
  const outputEl = document.getElementById("output");
  const runBtn = document.getElementById("runBtn");

  runBtn.addEventListener("click", async () => {
    outputEl.textContent = "Ejecutando...";

    try {
      // Invoca el comando Rust
      const result = await invoke("ejecutar_mibash");
      outputEl.textContent = result;
    } catch (error) {
      outputEl.textContent = "Error: " + error;
    }
  });
});