workflow "Test Assembler" {
  on = "push"
  resolves = ["Test Assembler (Unit)", "Test Assembler (End-To-End)"]
}

action "Test Assembler (Unit)" {
  uses = "./Assembler/actions/unitTestAssembler"
}

action "Test Assembler (End-To-End)" {
  uses = "./Assembler/actions/e2eTestAssembler"
}
