ENV["JULIA_PKG_PRESERVE_TIERED_INSTALLED"] = true  # prefer to add already installed versions of packages, which are more likely to be precompiled.
ENV["JULIA_CONDAPKG_BACKEND"] = "Null"   # Use global python installation, and no Conda package management

int(x) = round(Int, x)

"""
    frac(num, den)

Does this really need explanation?
"""
frac(num, den) = /(num, den)

"""
    ln(x)

Compute the natural logarith of x.
"""
ln(x) = log(ℯ, x)

using Pkg
direct_dep_names = keys(Pkg.project().dependencies)

# Only activate general env if the current one is of a select julia version
# if VersionNumber(VERSION.major, VERSION.minor, VERSION.patch) == VersionNumber(1, 10)
#     Pkg.activate("GeneralEnv", shared=true)
# end

# Makie JuliaSyntax the default julia parser
if false  # JuliaSyntax is default from 1.10 onwards
    if "JuliaSyntax" in direct_dep_names
        @info "Found `JuliaSyntax` in direct dependencies.
        Setting it to the default parser."
        atreplinit() do repl
            @eval begin
                import JuliaSyntax
                JuliaSyntax.enable_in_core!(true)
            end
        end
    else
        @warn "JuliaSyntax not found in direct dependencies."
    end
end

if "OhMyREPL" in direct_dep_names
    @info "Running `using OhMyREPL`"
    @eval using OhMyREPL
else
    @warn "`OhMyREPL` not found in direct dependencies."
end

if "Revise" in direct_dep_names
    @info "Running `using Revise`"
    @eval using Revise
else
    @warn "`Revise` not found in direct dependencies."
end

# let local_pkg_dir = joinpath(homedir(), "GeekyStuff", "Julia", "LocalPackages")
#     if isdir(local_pkg_dir)
#         push!(LOAD_PATH, local_pkg_dir)
#         for package_folder in readdir(local_pkg_dir)
#             push!(LOAD_PATH, joinpath(local_pkg_dir, package_folder))
#         end
#     else
#         @warn "Provided path for local packages ($local_pkg_dir) is not a local directory"
#     end
# end

# Package templates
"""
    t = package_template()
    t("MyPackage")
"""
function package_template()
    original_dir = pwd()
    try
        cd(joinpath(homedir(), "GeekyStuff", "Julia", "Packages"))
        @eval using PkgTemplates
        return Template(;
            #user="KronosTheLate",  Taken from github global config
            #dir=pwd(),  use .julia/dev
            #authors="KronosTheLate",
            julia=v"1.6",
            interactive=true
            #=plugins=[
                Git(; manifest=true),
                GitHubActions(),
                Codecov(),
                Documenter{GitHubActions}(),
                Citation(),
                RegisterAction(),
                BlueStyleBadge(),
                ColPracBadge(),
            ]
            =#
        )
    finally
        cd(original_dir)
    end
end

function precompile_enviroments(update::Bool=false)
    env_dirs = readdir(joinpath(homedir(), ".julia", "environments"), join=true)
    for env_dir in env_dirs
        local env_ver
        try
            env_ver_str = split(readlines(joinpath(env_dir, "Manifest.toml"))[3], '=')[end][begin+2:end-1]
            env_ver = VersionNumber(env_ver_str)
        catch e
            @warn """Encountered error in trying to determine Julia version of project $(splitpath(env_dir)[end]):"""
            println(e)
            @info "Continuing"
            continue
        end

        if VersionNumber(env_ver.major, env_ver.minor) == VersionNumber(VERSION.major, VERSION.minor)
            Pkg.activate(env_dir)
            if update
                @info "Updating $(split(env_dir)[end])"
                Pkg.update()
            end
            @info "Precompiling $(split(env_dir)[end]))"
            Pkg.precompile()
        end
    end
end
