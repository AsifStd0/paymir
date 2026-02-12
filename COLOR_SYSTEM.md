# 🎨 Paymir App - Color System Documentation

## Overview

All colors used throughout the Paymir application are centralized in `lib/core/theme/app_colors.dart`. This ensures consistency and makes it easy to update the app's color scheme.

---

## 📍 Location

**Main Color File:** `lib/core/theme/app_colors.dart`  
**Theme File:** `lib/core/theme/app_theme.dart`

---

## 🎨 Color Categories

### 1. **Primary Brand Colors**

```dart
AppColors.primary      // #03110A - Dark green/black (Main titles, primary text)
AppColors.secondary   // #949494 - Medium gray (Subtitles, body text)
AppColors.tertiary    // #21BF73 - Green (Links, success indicators)
```

### 2. **Gradient Colors**

```dart
AppColors.gradient1   // #08A1A7 - Teal/Cyan (Buttons, cards)
AppColors.gradient2   // #4B2A7A - Purple (Buttons, cards)

// Pre-defined gradients:
AppColors.primaryGradient    // Horizontal gradient (left to right)
AppColors.verticalGradient   // Vertical gradient (top to bottom)
AppColors.cardGradient       // Card gradient (bottom-left to top-right)
```

### 3. **Text Colors**

```dart
AppColors.textDark        // #474747 - Dark gray (Page titles, headers)
AppColors.textMedium      // #3F3F3F - Medium dark (Tab labels)
AppColors.textDarkGray    // #424242 - Dark gray (Transaction items)
AppColors.textLightGray   // #929BA1 - Light gray (Secondary text)
AppColors.cardText        // #D3DDE5 - Light blue/gray (Card text)
```

### 4. **Background Colors**

```dart
AppColors.background      // #FAFCFF - Light blue/white (Screen backgrounds)
AppColors.white           // #FFFFFF - White (Cards, dialogs)
AppColors.backgroundLight // #F4F6F9 - Light gray (Service items)
AppColors.black          // #000000 - Black
```

### 5. **Accent Colors**

```dart
AppColors.success         // #45C232 - Green (Success messages, positive amounts)
AppColors.successVariant  // #32C774 - Bright green (Payment success)
AppColors.error           // Red - Error messages, warnings
AppColors.info            // #207797 - Teal/Blue (Information, links)
AppColors.warning         // Orange - Warnings
```

### 6. **Link & Interactive Colors**

```dart
AppColors.link            // #21BF73 - Green (Clickable links)
AppColors.signInLink      // #21BF73 - Sign in links
AppColors.signUpLink      // #21BF73 - Sign up links
AppColors.forgotPassword  // #7472DE - Purple (Forgot password links)
```

### 7. **Border & Divider Colors**

```dart
AppColors.borderLight     // #EBEBEB - Light border (Input fields)
AppColors.borderMedium    // #CCCCCC - Medium border
AppColors.divider         // #707070 - Medium gray (Tab dividers)
```

### 8. **Shadow Colors**

```dart
AppColors.shadowLight     // #0000000a - Very light shadow (Card shadows)
AppColors.shadowMedium    // #00000080 - Medium shadow (Text shadows)
AppColors.shadowDark      // Black with 0.5 opacity (Dialog shadows)
```

### 9. **Special Colors**

```dart
AppColors.tabIndicator    // #6045FF - Purple (Active tab indicators)
AppColors.purpleAccent   // #6E78F7 - Purple (Special highlights)
AppColors.cardIconBg     // #4B2A7A - Purple (Transaction item icons)
```

---

## 📝 Usage Examples

### Using Colors Directly

```dart
// Text color
Text(
  'Hello',
  style: TextStyle(color: AppColors.primary),
)

// Background color
Container(
  color: AppColors.background,
  child: ...,
)

// Border color
Container(
  decoration: BoxDecoration(
    border: Border.all(color: AppColors.borderLight),
  ),
)
```

### Using Gradients

```dart
// Primary gradient
Container(
  decoration: BoxDecoration(
    gradient: AppColors.primaryGradient,
  ),
)

// Card gradient
Container(
  decoration: BoxDecoration(
    gradient: AppColors.cardGradient,
  ),
)
```

### Using Theme Text Styles

```dart
// Main title
Text('Title', style: AppTheme.mainTitle(context))

// Subtitle
Text('Subtitle', style: AppTheme.subtitle(context))

// Body text
Text('Body', style: AppTheme.body(context))

// Link
Text('Link', style: AppTheme.link(context))

// Error
Text('Error', style: AppTheme.error(context))

// Success
Text('Success', style: AppTheme.success(context))
```

---

## 🔄 Migration Guide

### Old Way (Deprecated)

```dart
// ❌ Don't use these anymore
AppColors.primaryColor()
AppColors.secondaryColor()
AppColors.gradientColor1()
AppColors.gradientColor2()
```

### New Way (Recommended)

```dart
// ✅ Use these instead
AppColors.primary
AppColors.secondary
AppColors.gradient1
AppColors.gradient2
```

### Legacy Methods

For backward compatibility, the old methods still work but are marked as `@Deprecated`. They will be removed in a future version.

---

## 🎯 Best Practices

1. **Always use AppColors** - Never hardcode color values like `Color(0xff03110A)`
2. **Use semantic names** - Choose colors based on their purpose (e.g., `AppColors.success` for success states)
3. **Consistent usage** - Use the same color for the same purpose throughout the app
4. **Theme text styles** - Use `AppTheme` text styles when possible for consistency

---

## 📋 Color Reference Table

| Color Name | Hex Code | Usage |
|------------|----------|-------|
| Primary | `#03110A` | Main titles, primary text |
| Secondary | `#949494` | Subtitles, body text |
| Tertiary | `#21BF73` | Links, success |
| Gradient 1 | `#08A1A7` | Buttons, cards |
| Gradient 2 | `#4B2A7A` | Buttons, cards |
| Text Dark | `#474747` | Page titles |
| Text Medium | `#3F3F3F` | Tab labels |
| Text Dark Gray | `#424242` | Transaction items |
| Background | `#FAFCFF` | Screen backgrounds |
| Success | `#45C232` | Success messages |
| Error | Red | Error messages |
| Link | `#21BF73` | Clickable links |
| Forgot Password | `#7472DE` | Forgot password links |

---

## 🔧 Customization

To change the app's color scheme:

1. Open `lib/core/theme/app_colors.dart`
2. Update the color values
3. All screens will automatically use the new colors

**Example:**
```dart
// Change primary color
static const Color primary = Color(0xffYOUR_COLOR);
```

---

## 📚 Related Files

- `lib/core/theme/app_colors.dart` - Color definitions
- `lib/core/theme/app_theme.dart` - Theme configuration
- `lib/widget/custom/custom_text.dart` - Uses AppColors
- `lib/widget/custom/custom_button.dart` - Uses AppColors gradients

---

**Last Updated:** Based on current codebase  
**Maintained By:** Development Team
