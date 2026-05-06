// app.config.ts
import { ExpoConfig, ConfigContext } from 'expo/config'

export default ({ config }: ConfigContext): ExpoConfig => ({
  ...config,
  name: 'MyBudget',
  slug: 'MyBudget',
  version: '1.0.0',
  orientation: 'portrait',
  icon: './assets/icon.png',
  scheme: 'mybudget',
  userInterfaceStyle: 'automatic',
  splash: { image: './assets/splash-icon.png', resizeMode: 'contain', backgroundColor: '#0F172A' },
  ios: { 
    supportsTablet: false, 
    bundleIdentifier: 'com.thomas.mybudget',
    developmentTeam: 'P2Y4WW3JXW'
  },
  android: { 
    adaptiveIcon: { foregroundImage: './assets/adaptive-icon.png', backgroundColor: '#0F172A' }, 
    package: 'com.thomas.mybudget' 
  },
  plugins: [],
  experiments: { typedRoutes: true },
  extra: {},
})
