# GOcontroll-Simulink-Starter

A ready project folder for building applications for the GOcontroll Moduline controllers with
MATLAB Simulink. Clone it, start MATLAB in the folder, create a model from a template and build.

The blockset itself is the git submodule [`GOcontroll-Simulink`](https://github.com/GOcontroll/GOcontroll-Simulink).
Your models live in this folder, in your own repository; the blockset is updated with git and is
never edited by hand.

```
MyProject/                      this repository: your project
├── MyModel.slx                 your models go here
├── startup.m                   puts the blockset on the MATLAB path
├── librarySetup.m              forwards to the blockset (used when a model is opened)
├── build/                      build results (not in git)
└── GOcontroll-Simulink/        the blockset, a git submodule - do not edit
    └── blockset/
        └── GOcontroll-CodeBase/    the C code base, a submodule of the blockset
```

| Controller | Template |
|---|---|
| Moduline S1 | GOcontroll Moduline S1 |
| Moduline M1, L4, HMI1 | GOcontroll Moduline M1 / L4 / HMI1 |

## What you need

- **MATLAB R2023b or later** with Simulink, Embedded Coder, MATLAB Coder and Simulink Coder.
- **Git.**
- **A compiler** for the controller. Install it once per computer, after step 2 below, with
  one command in the MATLAB Command Window:

  | For | Command | Installs |
  |---|---|---|
  | Moduline S1 | `GOcontrollInstallCompilers S1` | Arm GNU Toolchain arm-none-eabi 14.2.rel1 (about 300 MB, from Arm) |
  | Moduline M1, L4, HMI1 | `GOcontrollInstallCompilers Linux` | GCC 9.2-2019.12 aarch64-none-linux-gnu (about 650 MB) |
  | Moduline M1, L4, HMI1, *Compiler* = Zig | `GOcontrollInstallCompilers Zig` | Zig 0.14.1 (about 80 MB) |

  `GOcontrollInstallCompilers all` installs all three; `GOcontrollInstallCompilers` alone shows
  what is installed. These are the versions the blockset is tested with. They go to a folder of
  your own user (`%LOCALAPPDATA%\GOcontroll\tc` on Windows), the build finds them there, and
  they stay when you update the blockset: nothing has to be added to `PATH`.

  A compiler you installed yourself also works when its `bin` folder is on the system `PATH`
  (restart MATLAB after changing `PATH`); a compiler installed with the command above is used
  first.

## 1. Get the project

Start your own project from this one with **Use this template** on GitHub, then clone your new
repository. Or clone this repository directly:

```
git clone --recurse-submodules https://github.com/GOcontroll/GOcontroll-Simulink-Starter.git MyProject
```

`--recurse-submodules` fetches the blockset and its code base. If the folder
`GOcontroll-Simulink` is empty after cloning, run this in the project folder:

```
git submodule update --init --recursive
```

Keep the path of the project folder short, for example `C:\Projects\MyProject`: the build
makes long file names and Windows limits their length.

## 2. Start MATLAB in the project folder

Start MATLAB with the project folder as its start folder; `startup.m` then runs by itself. If
MATLAB is already open, make the project folder the current folder and type:

```
startup
```

## 3. Create a model from a template

1. *Home > New > Simulink Model*.
2. In the group **GOcontroll** choose **GOcontroll Moduline S1** or
   **GOcontroll Moduline M1 / L4 / HMI1**.
3. Save the model **in the project folder**, with a name that is a valid MATLAB name
   (letters, digits and underscores, starting with a letter).

The model has three stages, **Input - Control - Output**, with working examples for the
controller signals, the modules, CAN, stored parameters and the LEDs. Read the **Disclaimer**
block in the model before you use it.

## 4. Choose the controller

*Modeling > Model Settings > Code Generation > GOcontroll options > Target*. A model made from
the Linux template can be set to the Moduline M1, L4 or HMI1; a model made from the S1
template is for the Moduline S1. For the Linux controllers also fill in the IP address of the
controller under *XCP address*.

## 5. Build

Make sure the project folder is MATLAB's current folder and press **Ctrl+B**.

The result is in `build/`: `<model>_<major>.<minor>.<patch>.elf`, `.a2l` and `.map`, and for
the Moduline S1 also `.srec` and `.bin`. The version comes from the **Software version** block
in the model.

## 6. To the controller

Moduline M1, L4, HMI1: send the newest build to the controller from the MATLAB command window:

```
ManualUpload MyModel 192.168.19.85
```

with the name of your model and the address of your controller.

## Updating the blockset

In the project folder:

```
git submodule update --remote GOcontroll-Simulink
git -C GOcontroll-Simulink submodule update --init --recursive
```

The first command fetches the newest blockset; the second puts the code base inside it on the
version that belongs to that blockset. Then restart MATLAB, build your models, and commit the
changed submodule together with your models:

```
git add GOcontroll-Simulink
git commit -m "Update the GOcontroll blockset"
```

Your project records which version of the blockset it uses, so an older project keeps building
with the version it was made with until you update it.

`git submodule status --recursive` shows the versions in use. To go back to the recorded
version before you have committed the update: `git submodule update --init --recursive`.

## More information

- [GOcontroll knowledge base](https://gocontroll.com/knowledge-base/)
- The **Help** button of every GOcontroll block explains how to use it.
- [GOcontroll-Simulink](https://github.com/GOcontroll/GOcontroll-Simulink), the blockset.

## License

MIT, see [LICENSE](LICENSE).
