import { invoke } from "@tauri-apps/api";
//Añade un listener al boton 
document.addEventListener("DOMContentLoaded", () => {
  const outputEl = document.getElementById("output");
  const runBtn = document.getElementById("runBtn");

  runBtn.addEventListener("click", async () => {
    console.log("Ejecutando el comando Rust...");
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