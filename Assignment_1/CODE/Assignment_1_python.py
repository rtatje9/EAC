import sympy as sp
import numpy as np
import matplotlib.pyplot as plt

# Symbolic variables
E, A, L, g = sp.symbols('E A L g', real=True)  # Constants
x = sp.Symbol('x', real=True)  # Independent variable
u = sp.Function('u')(x)  # Displacement function

# Constants definitions
rho = sp.pi**3 / L**2
s = g * sp.pi**4 / L**2
F = A * E * g * sp.pi**2 / L
r = (x / L)**2

# Distributed force
q = E * (rho * u - s * r)

# Hooke's law (we'll compute epsilon but it's not necessary to define as symbolic)
epsilon = sp.diff(u, x)
sigma = E * epsilon

# Equilibrium equation
eq1 = sp.Eq(sp.diff(sigma, x) + q, 0)

# Boundary conditions
cond1 = sp.Eq(u.subs(x, 0), -g)  # Displacement at x=0
du_dx_L = sp.diff(u, x).subs(x, L)
cond2 = sp.Eq(A * E * du_dx_L, F)  # Force at x=L

# Solve the BVP
u_sol = sp.dsolve(eq1, ics={u.subs(x, 0): -g, sp.diff(u, x).subs(x, L): F / (A * E)})
u_sol_simp = u_sol.rhs.evalf(4, subs={sp.pi: np.pi})


print("General Solution:")
sp.pprint(u_sol_simp)

# Apply numeric values for exact solution
L_val = 1
g_val = 0.01

# Substitute numeric values into the solution
u_sol_val = u_sol_simp.subs({g: g_val, L: L_val}).evalf(4)

u_sol_val = u_sol_val.replace(
    lambda expr: expr.func in [sp.sin, sp.cos],
    lambda expr: expr.func(expr.args[0].evalf(4))
)

print("Exact Solution with numeric values:")
sp.pprint(u_sol_val)

# Convert symbolic expression to a numerical function for plotting
u_sol_func = sp.lambdify(x, u_sol_val, modules='numpy')

# Plot the exact solution
x_vals = np.linspace(0, L_val, 100)
u_vals = u_sol_func(x_vals)

plt.plot(x_vals, u_vals, linewidth=2)
plt.xlabel('Initial position x')
plt.ylabel('Longitudinal displacement u')
plt.grid(True)
plt.title('Exact Solution Boundary Value Problem')
plt.show()
