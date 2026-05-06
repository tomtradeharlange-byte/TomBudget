---
name: TomBudget Design System
colors:
  surface: '#fcf8fb'
  surface-dim: '#dcd9dc'
  surface-bright: '#fcf8fb'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f6f3f5'
  surface-container: '#f0edef'
  surface-container-high: '#eae7ea'
  surface-container-highest: '#e4e2e4'
  on-surface: '#1b1b1d'
  on-surface-variant: '#464653'
  inverse-surface: '#303032'
  inverse-on-surface: '#f3f0f2'
  outline: '#767685'
  outline-variant: '#c6c5d6'
  surface-tint: '#4950c7'
  primary: '#474dc5'
  on-primary: '#ffffff'
  primary-container: '#6067df'
  on-primary-container: '#fffbff'
  inverse-primary: '#bfc2ff'
  secondary: '#166b4c'
  on-secondary: '#ffffff'
  secondary-container: '#a1f0c9'
  on-secondary-container: '#1d7050'
  tertiary: '#874c43'
  on-tertiary: '#ffffff'
  tertiary-container: '#a3645a'
  on-tertiary-container: '#fffbff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e0e0ff'
  primary-fixed-dim: '#bfc2ff'
  on-primary-fixed: '#02006d'
  on-primary-fixed-variant: '#3035af'
  secondary-fixed: '#a4f3cb'
  secondary-fixed-dim: '#88d6b0'
  on-secondary-fixed: '#002114'
  on-secondary-fixed-variant: '#005137'
  tertiary-fixed: '#ffdad4'
  tertiary-fixed-dim: '#ffb4a8'
  on-tertiary-fixed: '#370d08'
  on-tertiary-fixed-variant: '#6d372f'
  background: '#fcf8fb'
  on-background: '#1b1b1d'
  surface-variant: '#e4e2e4'
typography:
  display-amount:
    fontFamily: Manrope
    fontSize: 34px
    fontWeight: '800'
    lineHeight: 41px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Manrope
    fontSize: 22px
    fontWeight: '700'
    lineHeight: 28px
  headline-md:
    fontFamily: Manrope
    fontSize: 17px
    fontWeight: '600'
    lineHeight: 22px
  body-lg:
    fontFamily: Manrope
    fontSize: 17px
    fontWeight: '400'
    lineHeight: 24px
  body-sm:
    fontFamily: Manrope
    fontSize: 15px
    fontWeight: '400'
    lineHeight: 20px
  label-caps:
    fontFamily: Manrope
    fontSize: 12px
    fontWeight: '700'
    lineHeight: 16px
    letterSpacing: 0.05em
  label-sm:
    fontFamily: Manrope
    fontSize: 13px
    fontWeight: '500'
    lineHeight: 18px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  margin-main: 20px
  gutter-grid: 12px
  stack-sm: 8px
  stack-md: 16px
  stack-lg: 24px
  card-padding: 20px
---

## Brand & Style

The design system is engineered to transform financial management from a chore into a refreshing, high-end digital experience. The brand personality is **optimistic, precise, and transparent**, targeting young professionals who value both aesthetic beauty and functional clarity. 

The visual direction follows a **Modern Corporate** foundation infused with **Glassmorphism**. By combining the structured reliability of iOS-native patterns with vibrant, translucent layers, the UI feels energetic yet professional. This approach uses depth and light to organize complex financial data, making the interface feel breathable and intuitive rather than overwhelming.

## Colors

The palette is a sophisticated evolution of the pastel tones found in the reference material, optimized for high-contrast mobile legibility. 

- **Primary (Lavender Blue):** Used for primary actions, active states, and "Savings" indicators. It provides a modern, trustworthy anchor.
- **Secondary (Mint Green):** Represents positive cash flow, income, and "under budget" statuses.
- **Tertiary (Soft Coral):** Reserved for expenses, alerts, or "over budget" warnings.
- **Quaternary (Soft Blue/Lavender):** Used for categorization and decorative glassmorphism accents.
- **Neutrals:** A range of deep grays and off-whites ensure that financial figures remain the focal point.

While the palette is soft, all text-on-color combinations must adhere to WCAG AA standards to ensure data accessibility.

## Typography

The typography utilizes **Manrope** to bridge the gap between technical precision and modern approachability. 

- **Financial Data:** Currency amounts use the `display-amount` token with extra-bold weights to establish immediate hierarchy.
- **Hierarchy:** Clear distinction is made between section headers and data labels. 
- **Readability:** Line heights are slightly increased to provide "air" between line items in transaction lists. 
- **System Feel:** The font choice mirrors the geometric cleanliness of San Francisco while offering a more distinctive, premium character for the brand.

## Layout & Spacing

The layout follows a **Fluid Grid** model optimized for the iPhone's vertical viewport. 

- **Safe Areas:** A standard 20px lateral margin ensures content is never cramped against the screen edges.
- **Vertical Rhythm:** Components are stacked using an 8px base grid.
- **Information Density:** Lists use 12px gutters to separate categories, ensuring that even with many categories, the UI feels organized.
- **Grouping:** Related financial metrics are grouped into glassmorphic cards with generous internal padding (20px) to enhance readability and touch targets.

## Elevation & Depth

This design system treats depth as a functional tool to separate "Tracking" from "Action."

- **Glassmorphism:** The primary dashboard cards use a backdrop blur effect (20px-30px) with a semi-transparent white fill (80% opacity). This allows the vibrant background gradients to peek through, creating a sense of lightness.
- **Ambient Shadows:** Shadows are extremely diffused, using a 10% opacity of the primary color rather than pure black. This "tinted shadow" technique prevents the UI from looking muddy.
- **Tonal Layers:** The main background is a soft, neutral off-white, while interactive elements sit on "elevated" white or translucent surfaces to indicate tappability.

## Shapes

In alignment with modern iOS standards, the shape language is **distinctly rounded**. 

- **Primary Containers:** Large dashboard cards and "Summary" blocks use `rounded-xl` (1.5rem/24px) corners.
- **Interactive Elements:** Buttons and input fields use `rounded-lg` (1rem/16px) corners to feel friendly and ergonomic.
- **Category Icons:** Spending category icons are housed in "squircle" containers or circular backgrounds to provide a soft, playful counterpoint to the hard data of numbers.

## Components

- **Glassmorphic Cards:** The signature component. These feature a thin, 1px white border (20% opacity) to define edges against varied backgrounds.
- **Buttons:** Primary buttons use a solid Lavender Blue fill with white text. Secondary buttons use a "ghost" style with a 1.5px colored stroke.
- **Transaction Lists:** Clean rows with a high-contrast amount on the right and a vibrant category icon on the left. Icons use the pastel palette to color-code spending types (e.g., Mint for Groceries, Coral for Entertainment).
- **Progress Bars:** Thin, rounded tracks for budget tracking. The "filled" portion uses a subtle gradient of the category's assigned pastel color.
- **Segmented Controls:** Used for switching between Daily, Weekly, and Monthly views, featuring a soft sliding selector.
- **Input Fields:** Minimalist designs with floating labels; the active state is signaled by a soft glow using the Primary color.