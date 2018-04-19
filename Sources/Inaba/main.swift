import Core

let inaba = Inaba()
do {
  try inaba.run()
} catch {
  print("Whoops! An error occurred: \(error)")
}
