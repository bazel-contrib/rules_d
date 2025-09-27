"""Mirror of D compiler release information.

This file is generated with:
bazel run -- //tools:generate_compiler_versions_bzl -c ~/.cache/d_releases --github-token <GITHUB_TOKEN> \
    -o ${PWD}/d/private/sdk/versions.bzl
"""

SDK_VERSIONS = {
    "dmd-2.090.0": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.090.0/dmd.2.090.0.linux.tar.xz",
            "integrity": "sha384-a7UrzJMvzKFDtnUptBx0bndG0Dc4F1vtB8UZ2r243R5jRo1uDJqXTQ2DNFep778A",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.090.0/dmd.2.090.0.osx.tar.xz",
            "integrity": "sha384-XzKPwyC38HX+2n85RF7LS3k9rG6HwY4DYU3cVCb9HibMGWNGJfWl0dVly0FUzTqk",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.090.0/dmd.2.090.0.windows.zip",
            "integrity": "sha384-daVRwWHs7BEfBYPzKIDc0Uza0KEuwBuVJWKH2OYXbzWy4Gshn7A187+0Gh7NceqN",
        },
    },
    "dmd-2.090.1": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.090.1/dmd.2.090.1.linux.tar.xz",
            "integrity": "sha384-0oyzhGOOiggMoNq5TxN/HvmQ2nxlBYAWDKDfTGsXhpJV5Ws46J1PnnIamNm7tVCh",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.090.1/dmd.2.090.1.osx.tar.xz",
            "integrity": "sha384-/bmq3judIVriThCjXUQIt3umB5oc1IwzS6pue5gH+3+t+1J9HJCQxGJ2ygtvKlnZ",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.090.1/dmd.2.090.1.windows.zip",
            "integrity": "sha384-kj1l0zYjz0WH4uyjbEIRnscgu7nHgr2lpQtJzxIdyzwq07DQFyObm1u6uwVMGc/N",
        },
    },
    "dmd-2.091.0": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.091.0/dmd.2.091.0.linux.tar.xz",
            "integrity": "sha384-bVfAi2jh2fx6MGwVylmOuy/vDgvpdwsu+m6ithkxyl2dU27egfLmLXWg4z2ZauOv",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.091.0/dmd.2.091.0.osx.tar.xz",
            "integrity": "sha384-l2OD8TGFaKmab9g/gSKI3fZaCLo+iONUlbABH1Fub+lKLhAulP44j3dQ4e7ajg/1",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.091.0/dmd.2.091.0.windows.zip",
            "integrity": "sha384-tEPenWGBuImaNU2c4UIud0bwvWIjweSIxBZcwe3YU7ZRdSMHhhPJXe8U0RreH6L6",
        },
    },
    "dmd-2.091.1": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.091.1/dmd.2.091.1.linux.tar.xz",
            "integrity": "sha384-2D6M2XSfoaOvzUpcxezTwAiQYwtL9zu+4ew+6d/Tu45URveGR/30eN+BAQssbLWI",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.091.1/dmd.2.091.1.osx.tar.xz",
            "integrity": "sha384-imhHIuIIYP1GztY8ZW4nVXX4E7urHOmCEfZ7Mz0UiQoBTspLw6HNjyiqujI0NxnG",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.091.1/dmd.2.091.1.windows.zip",
            "integrity": "sha384-8GaazV0GUBwRY1WsVV83m+BlYD7czvxIZEzi4Rre61o99tNC+840+P87CwTJtvzZ",
        },
    },
    "dmd-2.092.0": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.092.0/dmd.2.092.0.linux.tar.xz",
            "integrity": "sha384-JxZmJzPaGQZaalbGeTvCzFBd5xlIXUrWGc9d9iBYbnUOs78A8aXvSzQ0SBmIGmkb",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.092.0/dmd.2.092.0.osx.tar.xz",
            "integrity": "sha384-+8v9zyCz6WvWSyDS47r3PGO7kc9K+/EAqChC9eAGFdeBr/NrsL6J6/7TG/aKMxlZ",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.092.0/dmd.2.092.0.windows.zip",
            "integrity": "sha384-bxGukKVQ013NBQ9RYNT4jm6BA1EI0x4bDk0/Qp0UavxZmmY9cWKoFIfpnMPRp6q0",
        },
    },
    "dmd-2.092.1": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.092.1/dmd.2.092.1.linux.tar.xz",
            "integrity": "sha384-Gnb9/WwYltjgEUmbt4kJXWtTwy7VelH+gK21Zt7pdBODlU/hEQEaEGtqZliDshrf",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.092.1/dmd.2.092.1.osx.tar.xz",
            "integrity": "sha384-YK0wa3Z8dbbL1+YJV5Rj9zuCgfLaWo4A/L0jMtTV4rQooR6Dtw4WYTLwLZGGir1G",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.092.1/dmd.2.092.1.windows.zip",
            "integrity": "sha384-z6fmfQ1L11j8PcV1G/lEUY2jvM3GAWWhEqVigtTmQt09FUHYHiDLg3VMUY45/r89",
        },
    },
    "dmd-2.093.0": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.093.0/dmd.2.093.0.linux.tar.xz",
            "integrity": "sha384-+xaucMDaJC+hdPGKh0TCXO+o10IHSlI2uHdHH8cXCAMF6dHqZfWvVb5Z91H32x7I",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.093.0/dmd.2.093.0.osx.tar.xz",
            "integrity": "sha384-Rvv73pOe1AIAelqIkYZemy3beRKLQ/IqCRcMtEuPDuFqelkiuHoE+CJPBqF88nRo",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.093.0/dmd.2.093.0.windows.zip",
            "integrity": "sha384-8Br6vx4vwZd7GvtfbrAfjCde1tA6quIVQAhoS8gy3LmlUf7ABDaO5mbTS75lBL6J",
        },
    },
    "dmd-2.093.1": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.093.1/dmd.2.093.1.linux.tar.xz",
            "integrity": "sha384-2nseARDyt9JM0adC6nc4krm4KTycIKVIozozfMcpoAH4dqv3sqp2SxyGHh8MQlPx",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.093.1/dmd.2.093.1.osx.tar.xz",
            "integrity": "sha384-tb+DrKmBdtNDXcUIGgNWE/ewyJ2Q6FNQ5VYTD19c3VDjB8ApgpTftV1ei6kzcXGz",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.093.1/dmd.2.093.1.windows.zip",
            "integrity": "sha384-Q3xYNby2EEV+BGkTZYXMlDVTY+6RLNrLDEeDUCfwt/CwUHrx9Rvmaj8KNSumVe46",
        },
    },
    "dmd-2.094.0": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.094.0/dmd.2.094.0.linux.tar.xz",
            "integrity": "sha384-tVOHJI4uYuytKDQRTtBLmsUjDa56fDwRXsxi00Z+zCYQ/0XA8W5S1VLGefVw83X6",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.094.0/dmd.2.094.0.osx.tar.xz",
            "integrity": "sha384-9WtDYhrc8D89rx7hYaXCzSv7zZK5QQM05FF6SZPswoZM+7Itx1i6gyKtlCxdRBAR",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.094.0/dmd.2.094.0.windows.zip",
            "integrity": "sha384-e5mbHxcFb92gkuNbWhMrv1zfzg9nAuurH2Ik0e7AUDZ8+HXeglWcL9NaCmPiv4eO",
        },
    },
    "dmd-2.094.1": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.094.1/dmd.2.094.1.linux.tar.xz",
            "integrity": "sha384-8HXLVlMWns18h8jXLfi58J74B8Wd3iY2Dr8BHUz8un8MqL8wig9cSbdGB8r8mS2i",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.094.1/dmd.2.094.1.osx.tar.xz",
            "integrity": "sha384-TuCzNUf8fO7LPKOtmSI3ED6UALnBixTOJCEMDyj4JnL/0AVvSiaQqeol6iPl7BIr",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.094.1/dmd.2.094.1.windows.zip",
            "integrity": "sha384-jn+xfMpmOQRKzuDeMrWZA8gLRCRD5jzgbwiQtGKJhepjjBIlfH1YhYprC9Juu8au",
        },
    },
    "dmd-2.094.2": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.094.2/dmd.2.094.2.linux.tar.xz",
            "integrity": "sha384-RVoqRJaSK+XPUmx+BwE1AaFfRix17+vum30IJPXDbsEIFjKK8G0jpN1eQU5qnM4t",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.094.2/dmd.2.094.2.osx.tar.xz",
            "integrity": "sha384-taqhRXggazSCA8v6bIiDER5/MfiE7yL1wTj4v2DwUJd1ipRyNpk+WW5veTJqgJ8W",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.094.2/dmd.2.094.2.windows.zip",
            "integrity": "sha384-PtIiloB/nqW3+27/aOp3/JF/JVVwA4ZawkACuNcgDT+D5qLE0PmLYhWaEHmRE2YL",
        },
    },
    "dmd-2.095.0": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.095.0/dmd.2.095.0.linux.tar.xz",
            "integrity": "sha384-7M7D7lU74PlIdaEftYhyT+U0UuXI3PWxiHMxxu+lOXj+GN8mXJGw4Xp/h7hgiZHB",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.095.0/dmd.2.095.0.osx.tar.xz",
            "integrity": "sha384-NFdldUrTTX8zkNzMgFUwB3NNptgapQhxfRHuB47CkBAyKCfZRsZdlzmVMgTZpgix",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.095.0/dmd.2.095.0.windows.zip",
            "integrity": "sha384-8fX2zpwwXXxQ2SFf4MahRvWQXn6D2irKFhhTYEPFpSj9O6OKMoaWe6VlGo+vs0xl",
        },
    },
    "dmd-2.095.1": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.095.1/dmd.2.095.1.linux.tar.xz",
            "integrity": "sha384-TvQdBWSUHh8x7jud6DzTBD0QNWQwMWM0DzzkEIQcALo2epVrfJT8X/uMrCUUoGjf",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.095.1/dmd.2.095.1.osx.tar.xz",
            "integrity": "sha384-1957Y1l/PuPVQsqCrg6zgwcqLJVmjIf0SZN+gJXe0rfSaTZDI4L+swZOI/x0SPwc",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.095.1/dmd.2.095.1.windows.zip",
            "integrity": "sha384-xMFj+h3M7R4NNs9rslIZ0I99/oSFMPyZ5cNbJVkBDYnRJcmEDdVaemVJ4S9Jj56m",
        },
    },
    "dmd-2.096.0": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.096.0/dmd.2.096.0.linux.tar.xz",
            "integrity": "sha384-qkEpLSDS94dUxfJOr1TZfe/8TSvI74DEacE3Pdsnpv+8qiYozmsO0FAcCc5aRBdi",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.096.0/dmd.2.096.0.osx.tar.xz",
            "integrity": "sha384-VaPSL+8CnbNxfSBa9C0EYRa3tGbPXQXMDzQBwaAQ7r0PFcQzS8gix6Rdkqvrgb6Q",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.096.0/dmd.2.096.0.windows.zip",
            "integrity": "sha384-Yzk8S6mIdqztidSFLSRDXhhxKlEQ8q9H0KLvD0yfrfZO47xYJ8dt1QocXphcO9d9",
        },
    },
    "dmd-2.096.1": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.096.1/dmd.2.096.1.linux.tar.xz",
            "integrity": "sha384-Sfo3yEFy5Y4Oq9LSmFkZvldpKHZfzj3kz90jKcA7flqOEOmyV8tfUgEMMciYlo7N",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.096.1/dmd.2.096.1.osx.tar.xz",
            "integrity": "sha384-DIlc2jVvjHqEdK2BGUkpQSBeK6ZSw42g+ZrC+ZOK/zujt0heyVY/bK0/HYc6teHR",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.096.1/dmd.2.096.1.windows.zip",
            "integrity": "sha384-vu2kUK3HfeLR/4octytAmkdzI6MYYCdV4ulcW0hyWjJlabIEyQ81s8UAvfsuyE6B",
        },
    },
    "dmd-2.097.0": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.097.0/dmd.2.097.0.linux.tar.xz",
            "integrity": "sha384-py1Z7rsWI6OItY7+pxVYnD7YZJQ/h0WY889f/zS+gfTPGuSJOqID9E9e1vOseoyf",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.097.0/dmd.2.097.0.osx.tar.xz",
            "integrity": "sha384-hcA1x65EmnH4M45ItuA+jPNkCKMx3I1VoY3chofU/qkC86yshOmB9g+jmygqQNn5",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.097.0/dmd.2.097.0.windows.zip",
            "integrity": "sha384-85vZmoWQHKtcvpKwejJYaOxD7yGj+IjgIs/2BCCFKBbWrS/0uzQE7+/viCYkwL29",
        },
    },
    "dmd-2.097.1": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.097.1/dmd.2.097.1.linux.tar.xz",
            "integrity": "sha384-84RpavlLrCYZSD7h/tBufki89y6RyTqnlgUfpz0OieSKUpq/24z+8+pA98Dimeow",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.097.1/dmd.2.097.1.osx.tar.xz",
            "integrity": "sha384-JTiLd/PXb5YNaYfLiuWo9idQlDubCC8SMtcR/B4IEULdsoyGBaGzdkNX+6/wY6Te",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.097.1/dmd.2.097.1.windows.zip",
            "integrity": "sha384-HFj5J/ht9BH5wkZuomnSm9hbTBXz6aMbKIaUkxmqbwGXQ0cBA1ZrOJw2CP/OQV6h",
        },
    },
    "dmd-2.097.2": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.097.2/dmd.2.097.2.linux.tar.xz",
            "integrity": "sha384-cCGw/sqxJzoHYzQROFUJweaeygzJimUy/BdAL4OT0mB0W4AfGfCBZQcoFw+SD1eO",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.097.2/dmd.2.097.2.osx.tar.xz",
            "integrity": "sha384-NecY35jtUVOVhQn+8LT0ZPzxKUHPvgaoIMVnpJIWk6Jbggplcjo0/LSdSwIiy85o",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.097.2/dmd.2.097.2.windows.zip",
            "integrity": "sha384-LWnJkoYnSXEY1AHQk3iOJy5JD5kWaP3jsYrc415zqCp0ispkACKVGe4GP6DjefBH",
        },
    },
    "dmd-2.098.0": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.098.0/dmd.2.098.0.linux.tar.xz",
            "integrity": "sha384-kE3gZ41+RyIo3Wd7xK7K3X2fMjv/hxBpeSmAonTEPzRq6GqEAENRReCtEsBK7Fg9",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.098.0/dmd.2.098.0.osx.tar.xz",
            "integrity": "sha384-K5DlzaJ8aBNVrh28gXbbvTJOVZUhbmRIkUt6PPlaDQjC49iJb4xCb880hwn3ZoeN",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.098.0/dmd.2.098.0.windows.zip",
            "integrity": "sha384-43W/1okHnCWiPJiPXHuqOH7Aa3w4yTjfiPdYqvwQVhz1i24TLQGsS7KTHGQveV1b",
        },
    },
    "dmd-2.098.1": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.098.1/dmd.2.098.1.linux.tar.xz",
            "integrity": "sha384-wPPj3dyaRs0t/C6nlpqY6nFCxznwTwfRo2/qz5JLulPgGoWhFdii1L6WqEi0e5SB",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.098.1/dmd.2.098.1.osx.tar.xz",
            "integrity": "sha384-XDPbi93u9mQInV2S05wJ1GTDNWhCBedorYpSVRf0ab+F5uvArLHIC9t1JPz+luKU",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.098.1/dmd.2.098.1.windows.zip",
            "integrity": "sha384-20XUwke42vI9WyBzMHGZP3ySd3cDO+thYYZgu+ghxg6rRm0x+Da/D6OeDev3rIQL",
        },
    },
    "dmd-2.099.0": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.099.0/dmd.2.099.0.linux.tar.xz",
            "integrity": "sha384-JfobDuwH9GzDrrTTYudsGfAfsmhLiNBzJb/mQOMGMhNhHi+m4UnXgaBb9IsN5n/y",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.099.0/dmd.2.099.0.osx.tar.xz",
            "integrity": "sha384-cdL6rvIXKz/m8nODE/M7DfVphNywreBWu1jTps5CjTsW86Ezf0TCHyWld1HqFq/1",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.099.0/dmd.2.099.0.windows.zip",
            "integrity": "sha384-5x0SCIDsK4NRRWRroR95UifJI8N9d1Xai8FDjwrhcGa8QzyoQ8BVPRZ8k7Giy2TW",
        },
    },
    "dmd-2.099.1": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.099.1/dmd.2.099.1.linux.tar.xz",
            "integrity": "sha384-8EbSTJOuipYE6pnQvjiYE/31toMr8+359JBj+eJhhiQDy/aradpeYgapOvoZJSMf",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.099.1/dmd.2.099.1.osx.tar.xz",
            "integrity": "sha384-H3kmlQ3anAQjdfGBrHfKhQyGyhyOMKz1w3g7kkUgR8FYycYsH+rmWPslfgCFs9Bx",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.099.1/dmd.2.099.1.windows.zip",
            "integrity": "sha384-c/g9Yzuqe6mFkYlUguk+aB0dSrNipwxLE1iGbTuY2Evt8ZSE1bCPUZmMG4QMyt/j",
        },
    },
    "dmd-2.100.0": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.100.0/dmd.2.100.0.linux.tar.xz",
            "integrity": "sha384-M6pOB4gyVI9kcwHs1fZ9/Sv+0m72WqkDNzPR9+fpWgEGHZsSGP3nUgasuuwUynxX",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.100.0/dmd.2.100.0.osx.tar.xz",
            "integrity": "sha384-8oCQueOW2mkVg9JDMgX/rhBzb7xJc1kHLOHlKlxX9oqqDC+jz7rb9H8PtIv2OePi",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.100.0/dmd.2.100.0.windows.zip",
            "integrity": "sha384-49eZh/8jJNdEOKo2G3kNa8rdpkwZaY7XXouy2+eYR6aKMb9T/ywkJgxL2ClxDDbf",
        },
    },
    "dmd-2.100.2": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.100.2/dmd.2.100.2.linux.tar.xz",
            "integrity": "sha384-w69orvCOZ0uGOeiZs+NzkBMbUVc4JmkbVhYaYIBPQ1ab9Z9LITTSlORf9UNUDzhM",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.100.2/dmd.2.100.2.osx.tar.xz",
            "integrity": "sha384-LOm86kwGAAbYpO7uYbWQIvFB9NDMCfIW3j05hDa+MWl7qCfB1MzNaHiLheLJW8+e",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.100.2/dmd.2.100.2.windows.zip",
            "integrity": "sha384-i0wnGJ6c0JXs6Qqc16Op4IJLy5UzBgWsfB1SiBN5AzR9KRxFPs+OfJ6WGBriy6Zg",
        },
    },
    "dmd-2.101.0": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.101.0/dmd.2.101.0.linux.tar.xz",
            "integrity": "sha384-x/3MZk+iTcOPW5PG4UqEkYj3W94mMRzM4LNicIEUIIALvtbDaDVz71wuHm9zC3/h",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.101.0/dmd.2.101.0.osx.tar.xz",
            "integrity": "sha384-KitOi7mImTdGhCrhhe7QSTG0sFlC+C3iLa4w2cbbTON+ZWTJYQV6XoebQpVn5hh4",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.101.0/dmd.2.101.0.windows.zip",
            "integrity": "sha384-XJKAD2GjInlRQP2G2oYkkIpJi881Jio+LpQSC5tZatdS3ynCa9oBwIE8oLaOfSRk",
        },
    },
    "dmd-2.101.1": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.101.1/dmd.2.101.1.linux.tar.xz",
            "integrity": "sha384-4p4orrmndfcqUxToJ6um9yYwuUqZ6O/pXGBrkm2zSJWgHdLwg3h2jdclVqZdaTv2",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.101.1/dmd.2.101.1.osx.tar.xz",
            "integrity": "sha384-FjGR6M/RjNM9AEqLr8oQDsq+zHbNicQM2X4Cip2xA2u6iWzXXbL8WMXtd7OGpBUB",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.101.1/dmd.2.101.1.windows.zip",
            "integrity": "sha384-Z4cO1nn6P7+UZgSskN4YeSrLjpY7nUXBZA4sBCj1Ar6aIxNSjLEx4a4Sl9j3+VPD",
        },
    },
    "dmd-2.101.2": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.101.2/dmd.2.101.2.linux.tar.xz",
            "integrity": "sha384-ZwUBlm4lVLSsAtW0dZ1t7xhtli/h2RQl7hdfvJbVymO/cccl0KWDNcCcCN6q+YUC",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.101.2/dmd.2.101.2.osx.tar.xz",
            "integrity": "sha384-gX/BrvAl3Op0W6f97DlPbLz5X94IwnhabPOEq1L9OxB13DwuZE3p68XTPHEBXnjJ",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.101.2/dmd.2.101.2.windows.zip",
            "integrity": "sha384-ZAVCJ3BAy106Royj3ak/IeCty3GA4n97PH4ereSBiB/ql6myM72qrjFTJzKbGTex",
        },
    },
    "dmd-2.102.0": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.102.0/dmd.2.102.0.linux.tar.xz",
            "integrity": "sha384-2hZTA1W4KPgPYUYcJ+9+Yic3Az2TGZz728iu7DYubcpSkVAVvUXUWIZaMIvTz3SZ",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.102.0/dmd.2.102.0.osx.tar.xz",
            "integrity": "sha384-Q+UijASUPrn8k+yEq4qsHeCvEWhN4839U6pCnkCKCLxPWtEOwpJWl+v0HsisK37t",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.102.0/dmd.2.102.0.windows.zip",
            "integrity": "sha384-L3nOLnOgp8ynSy5QbCe+jUQvODrZSV7HZb9U+O0qCJ0rn6/darI60s7u8LMGFody",
        },
    },
    "dmd-2.102.1": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.102.1/dmd.2.102.1.linux.tar.xz",
            "integrity": "sha384-qfDNu/XFJ8JGEULacCkTL5NwUVV6gNij7MnItTznO/3TwlZdsMZdxLklt96QZhhp",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.102.1/dmd.2.102.1.osx.tar.xz",
            "integrity": "sha384-ga+4h+bQa4HPXk3DzePFCluyfh2KGWm1iqlwN/n8Zj9X/44BxTrz6M7bCWbbknUX",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.102.1/dmd.2.102.1.windows.zip",
            "integrity": "sha384-41EmF8fGpFFk8jX1zaBPYNYfvxfZaA2WgPovJv+DdSLTbiU4CnOcdXfv0XlTe03w",
        },
    },
    "dmd-2.102.2": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.102.2/dmd.2.102.2.linux.tar.xz",
            "integrity": "sha384-8QrWBp/a58z53GyBtqOGd0M8ChKgbV4lSnl+4W6Hxfx6AUcBBcURGq5ZuZr/yZ+g",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.102.2/dmd.2.102.2.osx.tar.xz",
            "integrity": "sha384-YCd8FHA9gJfaPMMOkU0yT+P6kzDbfRhYlnekYab0B+z2x0VsaUlLMyvOEcM4Z61o",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.102.2/dmd.2.102.2.windows.zip",
            "integrity": "sha384-8fD+WUwMf0iyM+gaF+kVpnb3qOWawnKEsED+8NDbWLk6jNyveDcQEcRTeZYyZu4p",
        },
    },
    "dmd-2.103.0": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.103.0/dmd.2.103.0.linux.tar.xz",
            "integrity": "sha384-KEQu+8X+kr5ssmvPdGaBGK+izj4/5B5NqgGTeKsR02pc0EER2BKQDutlVcBF/EOt",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.103.0/dmd.2.103.0.osx.tar.xz",
            "integrity": "sha384-4a0B4Lm96Ju43h6BC1ru3AUisom6zLZbhb4hqqMHQ3uu9Q6y6xVbMQnPBiRnjFY5",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.103.0/dmd.2.103.0.windows.zip",
            "integrity": "sha384-OABjtTGwy8OWR3bc4jiXSAoIHJnY8o5FYpjMjXQAjzJI0iw2269CVQn7B0Ng6OLU",
        },
    },
    "dmd-2.103.1": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.103.1/dmd.2.103.1.linux.tar.xz",
            "integrity": "sha384-UGmy2Ov2t3IjkUM0c2Whsf2ehBAPIamo29W0kyO9lfy9EzAKePVTgXiB9OKXXokX",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.103.1/dmd.2.103.1.osx.tar.xz",
            "integrity": "sha384-D+qkb7o5Pqr8Q8kmZvz9QNi7GLrIZgfzDH4IS+w/3dH6fzee8kGJQ3V1Sy+jAZbD",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.103.1/dmd.2.103.1.windows.zip",
            "integrity": "sha384-Emill8OFj8qz6TKn78i2mBiNwpZuc2kx93A7LV9sXKjaSZnVEWIPhyhzi6IFZfHU",
        },
    },
    "dmd-2.104.0": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.104.0/dmd.2.104.0.linux.tar.xz",
            "integrity": "sha384-9NXKQtv9VZSy3ddBCTMiLi2ZGdbcCnGDqdTQ7u5UY63Ea91Om7j47eFILj7O9qSl",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.104.0/dmd.2.104.0.osx.tar.xz",
            "integrity": "sha384-hKee9KEcGMOwY42ZVh+4oo5HJMKeeKBgTkS0sIxr4gai+caJTxmlH1lAjWafdk8V",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.104.0/dmd.2.104.0.windows.zip",
            "integrity": "sha384-pQqMkIzlBTXhfmOgMYGUnaAHLDzTD1nYR2xdFrh9JMBItGQr+FBWt6Hr41algb6r",
        },
    },
    "dmd-2.104.1": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.104.1/dmd.2.104.1.linux.tar.xz",
            "integrity": "sha384-1OQyblNMH6ATp/WQ5G00y2VSb2ndxhqKNsGAiJqruvxqfEwtf9MAv63PoXPPs90H",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.104.1/dmd.2.104.1.osx.tar.xz",
            "integrity": "sha384-bneUXYXzIsKc2trS1NJrHr85F7OlMNUub6YJyRDYYkAWutojdmNDNbqgJsiw5Xg4",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.104.1/dmd.2.104.1.windows.zip",
            "integrity": "sha384-nSAN2zZwkU8Z0JqM891x/danGegMH/CMuy7CIjLB0EyVo6MIjEsKTGzNVsdl+8cR",
        },
    },
    "dmd-2.104.2": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.104.2/dmd.2.104.2.linux.tar.xz",
            "integrity": "sha384-IWdai4arS900Jna/aheM/D1L8bwAFSkOfa1bZyMz4IXNGcx9vuO9N0ZQ/LVmIkvL",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.104.2/dmd.2.104.2.osx.tar.xz",
            "integrity": "sha384-pGdw4OlLaFQmi4yOXt9czBR4p5N+YwbYYUSnfN2DYJmtKhsnK+lOZj+G+oQM2PUD",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.104.2/dmd.2.104.2.windows.zip",
            "integrity": "sha384-Up8tiaQHQD82uUeGfAIdE8D62X0+PS8g7T9HwJ7PYP1SxSNaEEziQd2KHNokedKy",
        },
    },
    "dmd-2.105.0": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.105.0/dmd.2.105.0.linux.tar.xz",
            "integrity": "sha384-4Utskg4Jhemhr+XfA5NiyvXEl14q6ak4XIEpxAmAiFWbWU/kFRr0KNiPL53+o3Si",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.105.0/dmd.2.105.0.osx.tar.xz",
            "integrity": "sha384-f4b79y0QL2VPyaRG9s9Bk3H7LxTt/7YC4nfj6S0pLksXvCejCfB1ZrBvml/SkH15",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.105.0/dmd.2.105.0.windows.zip",
            "integrity": "sha384-F9AeV6aG19oRyBBiA0gGW7TB8J3Jn2jXTgZcN5hJX3oDb5fzDEbffpbA7Q9M3wKG",
        },
    },
    "dmd-2.105.1": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.105.1/dmd.2.105.1.linux.tar.xz",
            "integrity": "sha384-lBY32G36D2X/2PiCORKeo8kGQJitwaqMI10tTbvClMDaPfWT8jGSwqAIeev2Yvc8",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.105.1/dmd.2.105.1.osx.tar.xz",
            "integrity": "sha384-vp72n/8YEuwpgEPjQqK9iwtBts3xUHj0UCLSJUNRLGZUIx5BSmzkkkIfIPeTbZ4g",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.105.1/dmd.2.105.1.windows.zip",
            "integrity": "sha384-YvECbboXxSESyt6KAHNz9DZoqto2MXjE+nnPfYqx5vu/eWT00jP+4E78g80StqZp",
        },
    },
    "dmd-2.105.2": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.105.2/dmd.2.105.2.linux.tar.xz",
            "integrity": "sha384-23rS814pVPjt6k/KKke2/GTUW3Ctmwj+6Z0vhrY2oZYlXoAVTy4Ev50FMxfhCAet",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.105.2/dmd.2.105.2.osx.tar.xz",
            "integrity": "sha384-uKhFRRqN0TXwMNz+MrzsCoCpaTZ9TOKrbtk2/jpn7HQJPNdzl03Wowe0nJ/BuWgv",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.105.2/dmd.2.105.2.windows.zip",
            "integrity": "sha384-d3NXrWLsejatfNdsKahKpNzAiyG8Bnxbe7tdxfCcM9vJnmwbPG5endJJyGDXYGez",
        },
    },
    "dmd-2.105.3": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.105.3/dmd.2.105.3.linux.tar.xz",
            "integrity": "sha384-3RCjrU01jynS3XjwqgbtK+tWjIPX4rAzNYpC4AvDjd5/jWj1HuhtvYoeITfA2QT4",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.105.3/dmd.2.105.3.osx.tar.xz",
            "integrity": "sha384-F2q/Ui84zVcyunoMmyYZ3UEigtYxNzMjkz+R8XFjilqtkepF5y1qoyUqNWDeSKFj",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.105.3/dmd.2.105.3.windows.zip",
            "integrity": "sha384-DMJ1FLNLoer6AGe4tebFoqbTeKj3+Add8kMWlFBLKk5A/6UkEVlcHos64IKxhMg1",
        },
    },
    "dmd-2.106.0": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.106.0/dmd.2.106.0.linux.tar.xz",
            "integrity": "sha384-9yPssidXprtYCzVOgeQaH9TtWPOmAMxXbTVIgbHFgPo+86VkEooPa49gMJSyK0f8",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.106.0/dmd.2.106.0.osx.tar.xz",
            "integrity": "sha384-e9V+eKk8D/OV1NQCWW1FNL4ntHTUp/FTesc/tIAimJXKUjFWOYJGAWGGNmGatl0m",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.106.0/dmd.2.106.0.windows.zip",
            "integrity": "sha384-8zar8B+MeBfZthW2nXOhviD4F79SAgic1Sh6itekuoWoakkrhGI3G7cqG//MVTHr",
        },
    },
    "dmd-2.106.1": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.106.1/dmd.2.106.1.linux.tar.xz",
            "integrity": "sha384-uf/hzYtAmJAMhm0RTc4YqjXlx2oKFLXCqmt3RHlMF35BaV0qCwJeeKtheCDHV7jS",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.106.1/dmd.2.106.1.osx.tar.xz",
            "integrity": "sha384-cakZfZG4NAwjyQefMXJW+L3kDvelS1afNX/1PuockTOu/ZSz0YyhdMnNCkwGHGTk",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.106.1/dmd.2.106.1.windows.zip",
            "integrity": "sha384-KiKnbq61f3eeraLSZO1OPggQ8B5yULCScn9bY0NVak0cMN96tdDP1R/QWlD9mHh2",
        },
    },
    "dmd-2.107.0": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.107.0/dmd.2.107.0.linux.tar.xz",
            "integrity": "sha384-d2A3LtbrXMThbN2YUIPYMcSWy07FIKSTUeP5bUAaEkntdXxVNw1BO9QOWpGQXknq",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.107.0/dmd.2.107.0.osx.tar.xz",
            "integrity": "sha384-hnFtz/CH8V3QuNoqlYePlywbo3lpVlYd8wI4m02gi2biHOPw8aw9mVUSPrYitYtf",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.107.0/dmd.2.107.0.windows.zip",
            "integrity": "sha384-a5fth5aB4opyjrrbDL+E+EEUZFGzrj66u60ohIgxuHRBLJ39CsCh+oaUR91swIoc",
        },
    },
    "dmd-2.107.1": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.107.1/dmd.2.107.1.linux.tar.xz",
            "integrity": "sha384-VcB/iKJsOGSA9ciZ1TL5JcG+QNZJYln4ASLXKDUavUiIyY/vwTxlrq/25TTN/lVU",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.107.1/dmd.2.107.1.osx.tar.xz",
            "integrity": "sha384-rNlE3fuu6cudDnrhtPsmB8uWwNu6rCIrrZ3Gb0sWHVBq+oSLfY2DotjfXQd9Qh2W",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.107.1/dmd.2.107.1.windows.zip",
            "integrity": "sha384-CZNCn5YQRoQMO5r0yIk5GcoC3VsjXLJ5QIehbehtbEkw1YDrEUcaTE+tntKWU7Z0",
        },
    },
    "dmd-2.108.0": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.108.0/dmd.2.108.0.linux.tar.xz",
            "integrity": "sha384-62kXcOB9492xMrkrndWEr50t7UvDOYU8ZrIUOxsH3B74yPlV4c5HflHWWm67dO+L",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.108.0/dmd.2.108.0.osx.tar.xz",
            "integrity": "sha384-tkP+Oyzu1vRBwgQm7snkceFybIMTs93blLhCETC/ZTLUt3SduIgkKi2apJS9USAd",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.108.0/dmd.2.108.0.windows.zip",
            "integrity": "sha384-dWj4y3u8ZepD7ZtOSLHLO4I/p+3G7INm2egUM9FgSRxMVkCwp40ZJNelj1zB236P",
        },
    },
    "dmd-2.108.1": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.108.1/dmd.2.108.1.linux.tar.xz",
            "integrity": "sha384-hZfrXDG/Wf4EK7abWf6yE2BbBGnFyxyhk5QS9XlJsmafGpbQd9OnDHoHz4m2nH0I",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.108.1/dmd.2.108.1.osx.tar.xz",
            "integrity": "sha384-pS+eeVo4H3v1H8zXd62m3ylSr2VJwZ0MGl/yXbNgENqDCIDNU9DRDnXvrpds9lu1",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.108.1/dmd.2.108.1.windows.zip",
            "integrity": "sha384-zsvgAujg74bIZJtwyk8n2cXv/3zo3fzWRYGK07oMT8Quj58wSyoFDtPqYdNM58OK",
        },
    },
    "dmd-2.109.0": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.109.0/dmd.2.109.0.linux.tar.xz",
            "integrity": "sha384-3wDGNIik8HzBwMM+1HVkDT+GXjv6cDv0RpSwLjywYSDx2dZqWsJ6+/U95dlqsDG2",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.109.0/dmd.2.109.0.osx.tar.xz",
            "integrity": "sha384-SlTlndBah6uwsVLVJUyspkaS9wpd47B9843QsSh9tNs3rXLsu3mFOBMVUZWV54iO",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.109.0/dmd.2.109.0.windows.zip",
            "integrity": "sha384-senc3nfM63LA4BLrSlRnlJz+712Yb548GbOpwUohB3pEPAl6Y8PhzF90vDLv6s/u",
        },
    },
    "dmd-2.109.1": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.109.1/dmd.2.109.1.linux.tar.xz",
            "integrity": "sha384-2S0+JWoWWpJbqcTDByozUWyaTLtWwukmjpnop1SyC9soFdJT62hX0VIhvb4TZXXl",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.109.1/dmd.2.109.1.osx.tar.xz",
            "integrity": "sha384-sUlJPRHUdR5mYmxKNbXpttjORiALIOfF6aIYrzZCdjCUXx0Hrmt7A+j7Y/CUG86K",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.109.1/dmd.2.109.1.windows.zip",
            "integrity": "sha384-Lv4d5pKXIicU3wemxzKii3fYu71GmPGAtpc/nqyzL3s1youopvKd2nBCyptDgnic",
        },
    },
    "dmd-2.110.0": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.110.0/dmd.2.110.0.linux.tar.xz",
            "integrity": "sha384-JeBWxaO3admbiphNSM4NodxTzJ1KfTndIDK555Df7QLne8COjo+3YksssAz/kmau",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.110.0/dmd.2.110.0.osx.tar.xz",
            "integrity": "sha384-PLnCInMPKLS+Cj0v/LCn5s2IfzTfHOcbZRekiQF4fKJornBPOMNe8z21T2O9DJO2",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.110.0/dmd.2.110.0.windows.zip",
            "integrity": "sha384-R3pe/ZIq0LRDrZ8cd6WMAVMcGZHOCzeqRqTX3Dve447bjOxxG4kEg9xxLPXbvXgo",
        },
    },
    "dmd-2.111.0": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://downloads.dlang.org/releases/2.x/2.111.0/dmd.2.111.0.linux.tar.xz",
            "integrity": "sha384-ZJdbkYwmz0iJ9b46HBHUAsoecbthZyIuihWsJ1UQEbgENFJ+6ZAvRCY7i8bG0P/Z",
        },
        "x86_64-apple-darwin": {
            "url": "https://downloads.dlang.org/releases/2.x/2.111.0/dmd.2.111.0.osx.tar.xz",
            "integrity": "sha384-+vwZ2YSNbkBvqsnioEYMKHKheaVh0w/NFnUuL2izY05En0tmaKpAf57SxeoEicNd",
        },
        "x86_64-pc-windows-msvc": {
            "url": "https://downloads.dlang.org/releases/2.x/2.111.0/dmd.2.111.0.windows.zip",
            "integrity": "sha384-MyiIaDOaDetXXf62ODHyvCJdnzvxrcirKUF172/ddP+eCM/iBUbOMIlundl0Wqo0",
        },
    },
    "ldc-1.20.0": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.20.0/ldc2-1.20.0-linux-aarch64.tar.xz",
            "integrity": "sha384-KlMxr9teUvAi6pqJRUy0TyRi1JP90E+S2BBCM4BGqdAehlmSa8CokLBd5fs2zLp0",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.20.0/ldc2-1.20.0-linux-x86_64.tar.xz",
            "integrity": "sha384-94XXxW/NXkryv06Mt/MNKcRKDH8cuvr3j2Z3MixzU5xkKyBTLq+hRoLZ+xs4jL+j",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.20.0/ldc2-1.20.0-osx-x86_64.tar.xz",
            "integrity": "sha384-+YFVjHUECBxsYcNZmJxmE0XWxn5qMAGGqrJMAXcJyg5SJn2S4n0tcEiWrKX5wHcq",
        },
    },
    "ldc-1.20.1": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.20.1/ldc2-1.20.1-linux-aarch64.tar.xz",
            "integrity": "sha384-kSCYvtQaQTZyV/wlzKyaoc4KlVXieRV4ZmZ9gjTI000DcICdmXtVHz444kepGgUD",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.20.1/ldc2-1.20.1-linux-x86_64.tar.xz",
            "integrity": "sha384-mZHM2aFsU8ugPoOs85Ub12W2PzIzDOvWh061fuW8x00E792g333i+T9WovEFVnhK",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.20.1/ldc2-1.20.1-osx-x86_64.tar.xz",
            "integrity": "sha384-O96ebfbK7hi/hMoBWnHawg69+kW6FasjdWBopNiF81ehKzlgmHQAdv5i5IBSudxi",
        },
    },
    "ldc-1.21.0": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.21.0/ldc2-1.21.0-linux-aarch64.tar.xz",
            "integrity": "sha384-tXwRRk/WLo/t8U4oMh4izUkavQK1R106zNGK8ltHNY2l8g+uJlZZExr96Su1oCoH",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.21.0/ldc2-1.21.0-linux-x86_64.tar.xz",
            "integrity": "sha384-HIVx11bMZVeTrRBAHFUdYJJbP5+MuJqIERGXdq4RBwbwdyROd/hLTsxxbKY6wKEU",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.21.0/ldc2-1.21.0-osx-x86_64.tar.xz",
            "integrity": "sha384-+K/ByXUIyBbInztNabp9Qm2HIbraFuMZt5No+wB7uEJ13azSjedSaKXNYLkDRIXs",
        },
    },
    "ldc-1.22.0": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.22.0/ldc2-1.22.0-linux-aarch64.tar.xz",
            "integrity": "sha384-FFwCEg8AJDAR5I6p0YCdydPYD2ZW30yyszhrrZLQaoNKj26Z/ofF8FkyOgYXMmfs",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.22.0/ldc2-1.22.0-linux-x86_64.tar.xz",
            "integrity": "sha384-zRU3HHls80ivmnT8h8m4tjm5vIggmrGesW+Wff5A+zHXfB3WQtjnEY8/WCITUZK3",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.22.0/ldc2-1.22.0-osx-x86_64.tar.xz",
            "integrity": "sha384-9t5FL1ZyeIjUMe5uVI9Ljpm343oJxBl3tDnkqhOnbSKlkLtaex1agKAO+xie5ZP8",
        },
    },
    "ldc-1.23.0": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.23.0/ldc2-1.23.0-linux-aarch64.tar.xz",
            "integrity": "sha384-mYshwPxzAITK6BTDRWvuVrojrA4jO4gcOCFr/HSEVS2pSW0Ykik28o+hD6ZKisTu",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.23.0/ldc2-1.23.0-linux-x86_64.tar.xz",
            "integrity": "sha384-d2Bm53I86z0aGKa1RHNoxFlC8TmAAUtF/DJDoFGvlyCrjY6FoudtaXn/spE22ko2",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.23.0/ldc2-1.23.0-osx-x86_64.tar.xz",
            "integrity": "sha384-2NSneqR6xprky/rzlqd0C6KuSyXhu8My/jvnmtIK4cPtTFTTIji3WDzlrFb8y2tU",
        },
    },
    "ldc-1.24.0": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.24.0/ldc2-1.24.0-linux-aarch64.tar.xz",
            "integrity": "sha384-gyCkhiA4E3SmkBdBVOtwFHV9Hayd+74PEJqBHz9txw4BqO913hCw86/55i+w4nbK",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.24.0/ldc2-1.24.0-linux-x86_64.tar.xz",
            "integrity": "sha384-xus//yink3E7wBIWKRmm4UK0A3g8FqhHDs/UplmHvZ7UkFCwMcsDplvuVu01+jML",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.24.0/ldc2-1.24.0-osx-x86_64.tar.xz",
            "integrity": "sha384-x/qNCeuLyIxO+QZYSe+j1jQ8WFgi40l7MnTHFohPVS4L4s6/aRAYB7nhLDPfQD7b",
        },
    },
    "ldc-1.25.0": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.25.0/ldc2-1.25.0-linux-aarch64.tar.xz",
            "integrity": "sha384-N4RfHPvCOuWiCFVfbGHDAgYxKILguW+xncwNycR3cWuJ3ABBfaAIbFq3sdO4JhCT",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.25.0/ldc2-1.25.0-linux-x86_64.tar.xz",
            "integrity": "sha384-AcSU7//lEVpnRjqEe4IbzMfZ8mXbspBHTYvCiUqNtjWUDQ1PdnVb90Xd6S8yqVsV",
        },
        "aarch64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.25.0/ldc2-1.25.0-osx-arm64.tar.xz",
            "integrity": "sha384-byySaPppPcQWKGcM+QJ/g8aVUYFVqOPvuPcs7iE9aYNwQ/xCRQokfbHUyr7y/kvS",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.25.0/ldc2-1.25.0-osx-x86_64.tar.xz",
            "integrity": "sha384-GgQhX75cv8+uoGJeNqWWYd6SoqS+LJuO84yS7t5l6+EZykdB724RajRa93sfD606",
        },
    },
    "ldc-1.25.1": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.25.1/ldc2-1.25.1-linux-aarch64.tar.xz",
            "integrity": "sha384-5vBik8oxmIZlpRAJ0ibls0pL4+9hx26ot9icRAanBFrwu+HE2R3mPa/fE2l5iR2S",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.25.1/ldc2-1.25.1-linux-x86_64.tar.xz",
            "integrity": "sha384-uKqYDgsMwtiq7PFS0WE9JbUsRXFZbFXsMZHtgapcDVGUMNdviGYJYnLq1wV0HoUy",
        },
        "aarch64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.25.1/ldc2-1.25.1-osx-arm64.tar.xz",
            "integrity": "sha384-678Y1I0WWqdgsHB3ho+I27TKpoeoewukim6/DOvqxByvBe0/YFqQyHdGw0cJmlFF",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.25.1/ldc2-1.25.1-osx-x86_64.tar.xz",
            "integrity": "sha384-a9170SZWiTbct2UzqHqyVjvJ+TIBa3aS2oLJkYvMsVqVfcBQWxm3h/4T26Wq4OnI",
        },
    },
    "ldc-1.26.0": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.26.0/ldc2-1.26.0-linux-aarch64.tar.xz",
            "integrity": "sha384-fvj3kl8LOK6f8Tav6/DXwQTc7tDNURry84h7pn/aRwN6FiN1w8IHB9dwrRX8brxS",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.26.0/ldc2-1.26.0-linux-x86_64.tar.xz",
            "integrity": "sha384-mo6V+jH1HOxLJ4ApjcNrKaxDwlZF7TnFND/lSpatwS442ZOUxOM8GstqNbzF/Kae",
        },
        "aarch64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.26.0/ldc2-1.26.0-osx-arm64.tar.xz",
            "integrity": "sha384-iTDLuJKJasAsxsteDlo6zIoFLNuTXVqQB78181fZwe+iyWPocOG8dAaq5uf+O+/e",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.26.0/ldc2-1.26.0-osx-x86_64.tar.xz",
            "integrity": "sha384-kKkcM84kUdvFmNpFAqTSrzF2WAflAjpxkFU3UqCkponc0mJAgRKekcMI4TA5i5qt",
        },
    },
    "ldc-1.27.0": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.27.0/ldc2-1.27.0-linux-x86_64.tar.xz",
            "integrity": "sha384-4jb51HEwTf3QPRDJmFttsJsijpzvqzD+nK9wc14jefLsG3m7iN98GtfgdQWKx2pr",
        },
        "aarch64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.27.0/ldc2-1.27.0-osx-arm64.tar.xz",
            "integrity": "sha384-w8hGLpR2oE6yBT+ERZi/IlPvt881AZtRT3dKzxcrdSgD8sNAS/YBMfT0cmMbtVod",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.27.0/ldc2-1.27.0-osx-x86_64.tar.xz",
            "integrity": "sha384-O8LCvu/lqWjpDu3FGRFmPxcsIHVxXvDp3KAIWEkC13BH1IFFksNAd2V/Wf7qSdqr",
        },
    },
    "ldc-1.27.1": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.27.1/ldc2-1.27.1-linux-aarch64.tar.xz",
            "integrity": "sha384-Shn+e5cnsGtcyDVbSDSK7EyXC2cMk3s3X+AAL0IZzJnUNEx7o2snfCY6FomI4y+3",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.27.1/ldc2-1.27.1-linux-x86_64.tar.xz",
            "integrity": "sha384-Hua8EmpF8Vq2NTc6GRxCjJct8/YEL+Vej6rlHpVrOtNYaA9mDgZAHpJBvYEns+UO",
        },
        "aarch64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.27.1/ldc2-1.27.1-osx-arm64.tar.xz",
            "integrity": "sha384-ldgde8UgcVZA+AOZTd/zhbBE744Orl5/NFWbCQh2M/4bX7PQ9TE+WnOulWraUteC",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.27.1/ldc2-1.27.1-osx-x86_64.tar.xz",
            "integrity": "sha384-k2Q/irXplJKUqhZZDHtUkMHZjmBMfnKcB2xr8QhZEeWYBJqEmb7lqu7cTxh81b+N",
        },
    },
    "ldc-1.28.0": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.28.0/ldc2-1.28.0-linux-aarch64.tar.xz",
            "integrity": "sha384-Pc4ZsBaDMRMIqYUfkBIpCaoGyK0dpDmc1CyevdJw+prL6V8lSnfPtQ7oo01Hav6k",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.28.0/ldc2-1.28.0-linux-x86_64.tar.xz",
            "integrity": "sha384-B1SjqtYdtRV3GingU1EnmUPY6Kzc1mO91qGVp0mqNDptK9V/RQiVZyzvsUat0NTL",
        },
        "aarch64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.28.0/ldc2-1.28.0-osx-arm64.tar.xz",
            "integrity": "sha384-Ym0vTyE3TxgK6+AgxPkHUqeGjK4YorbID+7TVzjGssoSneueTMkrLptNOIQKHiAO",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.28.0/ldc2-1.28.0-osx-x86_64.tar.xz",
            "integrity": "sha384-BzguuwWybinL1DKqX/1BqnVxC8rLlQSW+AcEWVevXBel3zCy4rmohCFJ5FgyxaAr",
        },
    },
    "ldc-1.28.1": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.28.1/ldc2-1.28.1-linux-aarch64.tar.xz",
            "integrity": "sha384-HrGD7snCQUmrNAdWsiTP3nBWUW0mlZNNAdBNsGzRy1AuJPINBMny3A8/rB9HgdIQ",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.28.1/ldc2-1.28.1-linux-x86_64.tar.xz",
            "integrity": "sha384-Eg11bYF+3mlR/xbt2YCXWtQ6RLC9BJbi1hXT+AI6fr3LWEups3G4RKpvqsTLQcYU",
        },
        "aarch64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.28.1/ldc2-1.28.1-osx-arm64.tar.xz",
            "integrity": "sha384-6tuljZRnGl+SRI58A1xO8ISO0/0pPmaxqOd0vqY1Y04GHdU3it7D4kMilWPE90Oi",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.28.1/ldc2-1.28.1-osx-x86_64.tar.xz",
            "integrity": "sha384-3udxV+6Wy4ggS+pmWT2cybsQh5A5KQVy58ZujPJVimJH2teHfCZ83VymWj1bIXMO",
        },
    },
    "ldc-1.29.0": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.29.0/ldc2-1.29.0-linux-aarch64.tar.xz",
            "integrity": "sha384-HKg/B/6WrCVTEOx6savg6/eKrk/ywXpnhoG1Iy8plQtzH7GdvE61KAuACq7IlsHw",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.29.0/ldc2-1.29.0-linux-x86_64.tar.xz",
            "integrity": "sha384-swEFf1IUzRVi7L3CgCpFbZuMoAsRQCpOkjAW9nEUzeezk2jkZORKtx8YJEbEDTlw",
        },
        "aarch64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.29.0/ldc2-1.29.0-osx-arm64.tar.xz",
            "integrity": "sha384-Ff8wmFptRn+1+UcNIvuSq5nPfpuKf7pEbTMUaw9wj2JGd3zWLatleB9T8SoKPBGz",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.29.0/ldc2-1.29.0-osx-x86_64.tar.xz",
            "integrity": "sha384-nwcObINdecKqTP/rNadp72ERme5z6uVM1uaaoaMJBuZFCWEd6MJuNovDj+r8dg+K",
        },
    },
    "ldc-1.30.0": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.30.0/ldc2-1.30.0-linux-aarch64.tar.xz",
            "integrity": "sha384-78G5QWxBYX7tXar96/DdvTb8Zwk4VE8VjjkA8wGjc0T30FdpVG7qtCIy0GTmTcwg",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.30.0/ldc2-1.30.0-linux-x86_64.tar.xz",
            "integrity": "sha384-cpbmUuQekrwm3NghjuS0WH5H54r/Yscd9sEOQOIbBSL9dAGQzTeAvEJkwR5sxm85",
        },
        "aarch64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.30.0/ldc2-1.30.0-osx-arm64.tar.xz",
            "integrity": "sha384-ws5UW5kYCFkSPk2f+c/tvugeR8FRu6oLUMqri1cdYSxbsVggzLxebdNb53ubRurY",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.30.0/ldc2-1.30.0-osx-x86_64.tar.xz",
            "integrity": "sha384-7pnStRevAiPmpZP8HWGxeYZ6Tz+jT5XDIIyq6FbU2AdNTLaEp29vQCs7eVvkOJS6",
        },
    },
    "ldc-1.31.0": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.31.0/ldc2-1.31.0-linux-aarch64.tar.xz",
            "integrity": "sha384-XtKwPEq9HkhrKOlGJ/vkFeB0apzEL4oa4rVpjEguEeCtPehxRgfecQ0j7V2IjzJb",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.31.0/ldc2-1.31.0-linux-x86_64.tar.xz",
            "integrity": "sha384-+jcQmUWQS1RW8p1EDkGAEs1v6m6waxySINhXNH7CIc2Ypn+xzwKEbfGId2a2RoQS",
        },
        "aarch64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.31.0/ldc2-1.31.0-osx-arm64.tar.xz",
            "integrity": "sha384-R7gOxVicrre0py9lQuYBCehSyQQr+2r1rtv5JlXC6VdgOl8v/FkAgykwlqLjMVWc",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.31.0/ldc2-1.31.0-osx-x86_64.tar.xz",
            "integrity": "sha384-FP2l1Ulwc0xL/B72cMoS7McSdLGTNnrTTD22dxkt/WDqtwDK/BSlbqAepumfRU1Q",
        },
    },
    "ldc-1.32.0": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.32.0/ldc2-1.32.0-linux-aarch64.tar.xz",
            "integrity": "sha384-rfw5bPp7hHyCpqsMzp7nEUnFUKFrGqt7PEWDlgYPeKUojfAKGayuC8DdzbhUQt1w",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.32.0/ldc2-1.32.0-linux-x86_64.tar.xz",
            "integrity": "sha384-jF74lCbhvRuH3bmrHwxZgMx8o67umrU0mt/Qb1mdf2clJPTw0veICiqT38swqCUp",
        },
        "aarch64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.32.0/ldc2-1.32.0-osx-arm64.tar.xz",
            "integrity": "sha384-DARGFuA5XPuQvcBiNMFy+Yq32WA9urKt2hRcVQsP0lf79NDy4ceOxAQlUFHzdJOM",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.32.0/ldc2-1.32.0-osx-x86_64.tar.xz",
            "integrity": "sha384-x+Xd3iec4It5hYZf38CFeqJlVuo8g+uBu3To80hCt4V1oc1ac15ZaSnNHmb5nPZy",
        },
    },
    "ldc-1.32.1": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.32.1/ldc2-1.32.1-linux-aarch64.tar.xz",
            "integrity": "sha384-jcdIi9Ie7cmJKCm9ka5t/zKChkF439cvYzEUfifLZItKZX4aF8A7tYbYRmp3DL1u",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.32.1/ldc2-1.32.1-linux-x86_64.tar.xz",
            "integrity": "sha384-Cu7NkaVnixulwD/OTwk4gPldt7WcmXBiaPaJhnbS7qUqXoeRl749zeIzF8+r/cZ0",
        },
        "aarch64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.32.1/ldc2-1.32.1-osx-arm64.tar.xz",
            "integrity": "sha384-8dEbLTepD+D5h5g++nmLtYVIZo1zEi1vLA7ozkDivBdi1HvFghXu9CqhNcj2CyO0",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.32.1/ldc2-1.32.1-osx-x86_64.tar.xz",
            "integrity": "sha384-Q2xh0E7xSdL9iBJ/UrqYb9d8uRbptMBZWzoceQCLll5EfapsRBPCd4FB83Bs5/u3",
        },
    },
    "ldc-1.32.2": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.32.2/ldc2-1.32.2-linux-aarch64.tar.xz",
            "integrity": "sha384-kCkKf+Kex0A3xJSb0QdFOtBiiWkZ/i99MraTzazuikuHiYIxEEzvQnTQZx8EaIrr",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.32.2/ldc2-1.32.2-linux-x86_64.tar.xz",
            "integrity": "sha384-5J7zP2MnHddtkWRHK+tTVu0YRBSiwsih9pF0xXtZywz4UlhrZ7HLC4mYQFDQR3nL",
        },
        "aarch64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.32.2/ldc2-1.32.2-osx-arm64.tar.xz",
            "integrity": "sha384-RVEmB2n7IG6fM2VypJEbZmVLwZL/KeGCemGAb5zro7BCzLD+H32ygPAlJQwbAuyr",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.32.2/ldc2-1.32.2-osx-x86_64.tar.xz",
            "integrity": "sha384-jorz1Bv7rYpueHBCkyHlVrLvni/T+hgS2ksdM7KZ8HqDRveziE30coHOvpR94FS1",
        },
    },
    "ldc-1.33.0": {
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.33.0/ldc2-1.33.0-linux-x86_64.tar.xz",
            "integrity": "sha384-RktNeei0xRSu28igQjBgNWi6Oud6WKmcAUaMTwPj/3lO5UQVs3bfP8LPPfTn63kD",
        },
        "aarch64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.33.0/ldc2-1.33.0-osx-arm64.tar.xz",
            "integrity": "sha384-Aus3kdgUQ+SJpHpOpdFmmrf3v+oaFqwYtLXeif5JULAuDnDJdpUXF4LTz3zcJGE3",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.33.0/ldc2-1.33.0-osx-x86_64.tar.xz",
            "integrity": "sha384-CnS17zpzOkfmU1x3EjwjEH5Sa0uLTX7GI8JQ6sFIJYLoyNZVhK3aRPOJab/VDyod",
        },
    },
    "ldc-1.34.0": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.34.0/ldc2-1.34.0-linux-aarch64.tar.xz",
            "integrity": "sha384-7hCpeZ8oOPrfSLYCBcHDkFDJmSb+j11YkzQzQfheLqDIKL5U5eZeuyRPrw4EX8fz",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.34.0/ldc2-1.34.0-linux-x86_64.tar.xz",
            "integrity": "sha384-ZtQejhjtQMqMQK0vVHWYDPNsh3/maudXQJo4mMo2FBhhIxhcGiEhC72yxrBk9iI2",
        },
        "aarch64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.34.0/ldc2-1.34.0-osx-arm64.tar.xz",
            "integrity": "sha384-DhU7eOO/9xR2Y+T+fTke8HFMY5dB1Ll5gYeFn6ayHrP+mINDH6axG9vueuD7Z+dm",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.34.0/ldc2-1.34.0-osx-x86_64.tar.xz",
            "integrity": "sha384-4FR1QKGbLCExIO6J8tewi4Fo3M5hyA82gE44CIhtCYUyoUGX6RgXVe1XxdfqQd+8",
        },
    },
    "ldc-1.35.0": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.35.0/ldc2-1.35.0-linux-aarch64.tar.xz",
            "integrity": "sha384-yrY+ulUIAZ81Dw3/vcUyoBN5xMAcV9vtAfFs/96yd72n4b8zLjsme5FSJ/gRc0P0",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.35.0/ldc2-1.35.0-linux-x86_64.tar.xz",
            "integrity": "sha384-7n0TyT4DBrJPeLUUFjz0zGSkiyWVeJuDmixyuLqnO4lY6+Di4fVKaIC0RCcGxXi2",
        },
        "aarch64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.35.0/ldc2-1.35.0-osx-arm64.tar.xz",
            "integrity": "sha384-NqDPI6TxG9pJq8YhOLEfDU0E4qVvZPomh8PgLur3qVNKatP/IcjhMZd4b+dUTk3f",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.35.0/ldc2-1.35.0-osx-x86_64.tar.xz",
            "integrity": "sha384-ZUjJwzsxIXWNO4bOdMQ/s6QxCRAgFbwlb5foNSXkcMbTIVEjDCmvEU1+mh+4OrMz",
        },
    },
    "ldc-1.36.0": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.36.0/ldc2-1.36.0-linux-aarch64.tar.xz",
            "integrity": "sha384-ua+dJkQa2vNG4g1AnFgKDpTXUC82kQBS+hU7J+778PcVNvInPiCAcUyNXgAXdyGC",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.36.0/ldc2-1.36.0-linux-x86_64.tar.xz",
            "integrity": "sha384-3ayUxODCovkMOJmTvAKSFQ9DCknzgrBi95XdzYM5+/nJmZp8p+qP18Nuaj3mbTwp",
        },
        "aarch64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.36.0/ldc2-1.36.0-osx-arm64.tar.xz",
            "integrity": "sha384-NRKIX/j33Lf33w59ndEV+ESXaWDB2jYJvBzC3qrH0BzkUjDqPWuz9cvdlXdppJon",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.36.0/ldc2-1.36.0-osx-x86_64.tar.xz",
            "integrity": "sha384-ZcaTssNDj2WE5s+Eb7kMwXr4BdZEOEjXMOIYSCjFh+rWj2wlMABMs63vyRHFdnC5",
        },
    },
    "ldc-1.37.0": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.37.0/ldc2-1.37.0-linux-aarch64.tar.xz",
            "integrity": "sha384-qcnY9lISZ0ygREAPfpb+evIkzF4cLgBfFTIgx362XUcfidSzWfP8eIqNWStGaeOe",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.37.0/ldc2-1.37.0-linux-x86_64.tar.xz",
            "integrity": "sha384-5TEe72o0ZrfFZayLtjcTJYjjIWQh3FRmSi2g7I/f2J2M5zFdpdQ5ODo5AvRZU5Oq",
        },
        "aarch64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.37.0/ldc2-1.37.0-osx-arm64.tar.xz",
            "integrity": "sha384-aFL9fWhsxAVAPp3oKqxDYn5tNKJFeLM189d/53oouIlNJwTB2vpjoeYNn21SZsVe",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.37.0/ldc2-1.37.0-osx-x86_64.tar.xz",
            "integrity": "sha384-020PB6hgnp93ULyAEkiitdt/CwHF9kyiByk5HeE0rW4LBXqDqHKWhGah+sP8Vo+0",
        },
    },
    "ldc-1.38.0": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.38.0/ldc2-1.38.0-linux-aarch64.tar.xz",
            "integrity": "sha384-02sReL9YuVy8bzOG7UCRLDDgro3erLIxgxWc+SGgicMj0GtgLMleIvsJdaeJ+GqH",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.38.0/ldc2-1.38.0-linux-x86_64.tar.xz",
            "integrity": "sha384-s00WF2CYqh7sCuMk4Q3PyFc9KVrwvDgHMT8g2cPaBTHqE2Q09lpYBgLeeYQ0b80E",
        },
        "aarch64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.38.0/ldc2-1.38.0-osx-arm64.tar.xz",
            "integrity": "sha384-DSt5dQLIUF+eKV0kszpUbsjvHBEDJjh9L0molbCmt5Nu+IZwoA1lPtlxJ/70FCKo",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.38.0/ldc2-1.38.0-osx-x86_64.tar.xz",
            "integrity": "sha384-3tP1pZqnz9Nb9aqD2ZqS5VDcaOGjuk+qDC0RPfFfKYpX+mUU726Itdw8r5702enO",
        },
    },
    "ldc-1.39.0": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.39.0/ldc2-1.39.0-linux-aarch64.tar.xz",
            "integrity": "sha384-aLjVhVRfTWDnN1PBK/YNkKOxb1uLBuzcUBtNm497xaaeHFVBCdiOHtjYTGE1S0I8",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.39.0/ldc2-1.39.0-linux-x86_64.tar.xz",
            "integrity": "sha384-c2Ka1YovwNkRW0+kZNtXBR/Ouh/Y0dMVWuoUj3y0vA0F6bZirppN80XY6IWbntF1",
        },
        "aarch64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.39.0/ldc2-1.39.0-osx-arm64.tar.xz",
            "integrity": "sha384-no4iFDuiXvTdsGwAGmqgXo394VFW0JXO1KmDq1ywm2PbiUDG+4HWeClAk6Ix7s4p",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.39.0/ldc2-1.39.0-osx-x86_64.tar.xz",
            "integrity": "sha384-ylB1RHtexZsViOuKaK5C6qpcs96H5l7SvKI3sfXM6YO8LpDbwjUsc1yDaDqjw3Sr",
        },
    },
    "ldc-1.40.0": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.40.0/ldc2-1.40.0-linux-aarch64.tar.xz",
            "integrity": "sha384-3I6gIWVU+vggLP4BqUBKQqLYGCQzsSMOuUZDGLs8cpp6kFKrytuLjD4A/92i9+HR",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.40.0/ldc2-1.40.0-linux-x86_64.tar.xz",
            "integrity": "sha384-dQfvUpXYGWKPQTiKbSAJUstkJLaL3Detq5+owbh//iUF1ZDmdRQf7/cHjP7vfAAY",
        },
        "aarch64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.40.0/ldc2-1.40.0-osx-arm64.tar.xz",
            "integrity": "sha384-BI5YaQPzAHRb4amUqqcQ2uHlcMux1lOSNqFFqa2vTQszbSY0TW85U+a3X72BQAB7",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.40.0/ldc2-1.40.0-osx-x86_64.tar.xz",
            "integrity": "sha384-BB4Ak0q668W7LFWODmJkKkaA/zE4Fol9dgYCEg4AWsu57cYsuN+Io7Km8dip+Hac",
        },
    },
    "ldc-1.40.1": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.40.1/ldc2-1.40.1-linux-aarch64.tar.xz",
            "integrity": "sha384-9yYuO4eVeJLW+RausW9Kto6OsmaViF2PkHEb+w2CXD/TfOh+6AxdVo/0vIkUd7mm",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.40.1/ldc2-1.40.1-linux-x86_64.tar.xz",
            "integrity": "sha384-hCS2QARrH02zQ60BXVnzEuPXGY0MGj2pHOAh4+RLzvW0i/qVlbKY55a960URm9rR",
        },
        "aarch64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.40.1/ldc2-1.40.1-osx-arm64.tar.xz",
            "integrity": "sha384-N9+Gyhrq9FeIxwRb8VRBd9bIAxeAzDivCSjbCIN+PHdWLybUweZu3I4aW/eJO5te",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.40.1/ldc2-1.40.1-osx-x86_64.tar.xz",
            "integrity": "sha384-GlfcIHRVUiT7bXx4ppBInbNUUxKPWNhRY3/L6O/eYZWHatxYc1HsAILAjmGoGoIX",
        },
    },
    "ldc-1.41.0": {
        "aarch64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.41.0/ldc2-1.41.0-linux-aarch64.tar.xz",
            "integrity": "sha384-9vDrjjlEeq/oOdhjM//Jf6qZCrDexyDwmNPTAyYYPI7Ww3tEVpLmTxAsXCWf6e/K",
        },
        "x86_64-unknown-linux-gnu": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.41.0/ldc2-1.41.0-linux-x86_64.tar.xz",
            "integrity": "sha384-jhptHueKFZuBk+vE7WlhGcaQmTW4RT09UL/8Ionu/zs+LNELENqysxsi2uCnkCUQ",
        },
        "aarch64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.41.0/ldc2-1.41.0-osx-arm64.tar.xz",
            "integrity": "sha384-SMLzly3r6fpTKf8+gvyBuFPZjBakiNecNaTCPwHj88SO6gLURIBc2ZJjKqey8Jb7",
        },
        "x86_64-apple-darwin": {
            "url": "https://github.com/ldc-developers/ldc/releases/download/v1.41.0/ldc2-1.41.0-osx-x86_64.tar.xz",
            "integrity": "sha384-Fmbq2sAUplXQIceDail9Ylxy21QM1rgAm32tBUl/qXPux+p8NeDg5FRfsANywdhK",
        },
    },
}
