// Prevents additional console window on Windows in release, DO NOT REMOVE!!
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

#[tauri::command]
fn ejecutar_mibash() -> Result<String, String> {
    use std::process::Command;

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
        .expect("error while running tauri application");
}


