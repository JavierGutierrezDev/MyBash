use std::process::Command;
use tauri::command;

#[command]
fn ejecutar_mibash() -> Result<String, String> {
    let output = Command::new("bash")
        .arg("mibash.sh")
        .output()
        .map_err(|e| e.to_string())?;

    let stdout = String::from_utf8_lossy(&output.stdout).to_string();
    Ok(stdout)
}

fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![ejecutar_mibash])
        .run(tauri::generate_context!())
        .expect("Error while running tauri application");
}