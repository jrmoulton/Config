import lldb

def jump_to_symbol(debugger, command, result, internal_dict):
    target = debugger.GetSelectedTarget()
    if not target:
        result.SetError("No target selected.")
        return

    # Iterate over all modules in the target to find the symbol
    for module in target.module_iter():
        symbol = module.FindSymbol(command)
        if symbol.IsValid():
            break
    else:
        result.SetError("Symbol not found.")
        return

    addr = symbol.GetStartAddress().GetLoadAddress(target)
    if addr == lldb.LLDB_INVALID_ADDRESS:
        result.SetError("Invalid address for symbol.")
        return

    process = target.GetProcess()
    if not process:
        result.SetError("No process running.")
        return

    thread = process.GetSelectedThread()
    if not thread:
        result.SetError("No thread selected.")
        return

    frame = thread.GetSelectedFrame()
    if not frame:
        result.SetError("No frame selected.")
        return

    frame.SetPC(addr)
    result.AppendMessage(f"Jumped to symbol '{command}' at address {addr}.")

def gdbr_command(debugger, command, result, internal_dict):
    debugger.HandleCommand('process kill')
    debugger.HandleCommand('gdb-remote 127.0.0.1:4242')



def __lldb_init_module(debugger, internal_dict):
    debugger.HandleCommand(
        'command script add -f jump_to_symbol.jump_to_symbol jump-to-symbol'
    )
    debugger.HandleCommand('command script add -f jump_to_symbol.gdbr_command gdbr')


