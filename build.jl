import Literate

Literate.markdown("littlewood.jl"; documenter = false, execute = true)
run(Cmd(`pandoc littlewood.md --output=littlewood.html`))
