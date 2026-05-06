---
name: Nocturnal Fiscal
colors:
  surface: '#13131a'
  surface-dim: '#13131a'
  surface-bright: '#393841'
  surface-container-lowest: '#0d0e15'
  surface-container-low: '#1b1b22'
  surface-container: '#1f1f26'
  surface-container-high: '#292931'
  surface-container-highest: '#34343c'
  on-surface: '#e4e1ec'
  on-surface-variant: '#c6c5d6'
  inverse-surface: '#e4e1ec'
  inverse-on-surface: '#303038'
  outline: '#908f9f'
  outline-variant: '#464653'
  surface-tint: '#bfc2ff'
  primary: '#bfc2ff'
  on-primary: '#131599'
  primary-container: '#7d84fe'
  on-primary-container: '#070494'
  inverse-primary: '#4950c7'
  secondary: '#4de082'
  on-secondary: '#003919'
  secondary-container: '#00b55d'
  on-secondary-container: '#003e1c'
  tertiary: '#ffb956'
  on-tertiary: '#462b00'
  tertiary-container: '#c78202'
  on-tertiary-container: '#3d2500'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#e0e0ff'
  primary-fixed-dim: '#bfc2ff'
  on-primary-fixed: '#02006d'
  on-primary-fixed-variant: '#3035af'
  secondary-fixed: '#6dfe9c'
  secondary-fixed-dim: '#4de082'
  on-secondary-fixed: '#00210c'
  on-secondary-fixed-variant: '#005227'
  tertiary-fixed: '#ffddb5'
  tertiary-fixed-dim: '#ffb956'
  on-tertiary-fixed: '#2a1800'
  on-tertiary-fixed-variant: '#633f00'
  background: '#13131a'
  on-background: '#e4e1ec'
  surface-variant: '#34343c'
typography:
  h1:
    fontFamily: Manrope
    fontSize: 40px
    fontWeight: '700'
    lineHeight: 48px
    letterSpacing: -0.02em
  h2:
    fontFamily: Manrope
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
    letterSpacing: -0.01em
  h3:
    fontFamily: Manrope
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: '0'
  body-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-sm:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '500'
    lineHeight: 20px
    letterSpacing: 0.01em
  label-xs:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.05em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 4px
  xs: 8px
  sm: 12px
  md: 16px
  lg: 24px
  xl: 32px
  2xl: 48px
  gutter: 24px
  margin: 32px
---

## Brand & Style
The design system adopts a **Corporate Modern** aesthetic with a sophisticated dark-mode twist. The brand personality is professional, secure, and illuminating, designed to reduce cognitive load for users managing complex financial data. By utilizing deep navy foundations and vibrant accents, the UI evokes a sense of "quiet intelligence."

The style focuses on precision and clarity. It avoids excessive decoration in favor of structural integrity, utilizing subtle tonal elevations to define the information architecture. The emotional response is one of calm control, ensuring that financial tracking feels like a seamless, high-end experience rather than a digital chore.

## Colors
The palette is anchored by a deep navy base (`#0F172A`), providing a low-strain environment for extended sessions. The signature brand blue (`#7C83FD`) serves as the primary action color, while a vibrant mint green (`#4ADE80`) is utilized for positive financial trends and secondary call-to-actions.

Text follows a strict hierarchy for readability: **High-emphasis** text uses crisp white (`#F8FAFC`), while **Medium-emphasis** and body copy use a muted slate grey (`#94A3B8`). Error states should utilize a soft coral red to maintain harmony with the cool-toned background without appearing jarring.

## Typography
The typography system uses a dual-font approach to balance character with utility. **Manrope** is used for headlines to provide a modern, refined, and slightly geometric feel that reflects the brand's precision. **Inter** is used for all functional text, body copy, and data visualizations due to its exceptional legibility in dark environments and its neutral, systematic nature.

Numerical data should prioritize tabular lining figures where possible to ensure financial columns align perfectly.

## Layout & Spacing
The system utilizes a **12-column fluid grid** for desktop and a **4-column grid** for mobile. A strict 4px baseline grid governs all vertical rhythm, ensuring components and typography remain perfectly aligned. 

Layouts should favor generous internal padding within containers to prevent information density from feeling overwhelming. Use `lg` (24px) spacing for primary content groupings and `sm` (12px) for related elements within a card or list item.

## Elevation & Depth
Depth is communicated through **Tonal Layers** rather than heavy shadows. As elements "rise" closer to the user, their surface color becomes progressively lighter:
- **Level 0 (Background):** `#0F172A`
- **Level 1 (Cards/Surfaces):** `#1E293B`
- **Level 2 (Modals/Popovers):** `#334155`

To enhance the premium feel, use **Low-contrast outlines** (`1px stroke`) using a slightly lighter shade than the surface itself. For floating elements like primary action buttons, a very subtle, diffused ambient shadow with a navy tint (`rgba(0, 0, 0, 0.4)`) may be used to provide separation from Level 2 surfaces.

## Shapes
The design system employs a **Rounded** (Level 2) shape language. This softens the technical nature of financial data, making the interface feel more approachable and modern. Standard components use a `0.5rem` radius, while larger containers like dashboards cards use `1rem`. Interactive elements like search bars or primary "Add Transaction" buttons may use `1.5rem` to distinguish them as high-priority touch targets.

## Components
- **Buttons:** Primary buttons use a solid `#7C83FD` fill with white text. Secondary buttons use a ghost style with a `#94A3B8` border and white text.
- **Input Fields:** Use the Level 1 surface color (`#1E293B`) with a 1px border. On focus, the border transitions to the primary blue with a subtle outer glow.
- **Cards:** Use Level 1 surfaces. Titles should be H3 (Manrope), and secondary data points should use Label-sm (Inter) in the secondary text color.
- **Chips/Badges:** For status tracking (e.g., "Paid", "Pending"), use low-opacity backgrounds of the status color (e.g., 15% green) with high-saturation text for contrast.
- **Progress Bars:** Use a thick 8px track in a dark slate, with the signature green for the fill to indicate budget health.
- **Lists:** Items should be separated by subtle horizontal dividers (`#334155`) with generous vertical padding (16px) to maintain touch-friendly targets.