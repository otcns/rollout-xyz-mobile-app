/// <reference types="npm:@types/react@18.3.1" />

import * as React from 'npm:react@18.3.1'

import {
  Body,
  Button,
  Container,
  Head,
  Heading,
  Html,
  Img,
  Preview,
  Section,
  Text,
} from 'npm:@react-email/components@0.0.22'

interface RecoveryEmailProps {
  siteName: string
  confirmationUrl: string
}

export const RecoveryEmail = ({
  siteName,
  confirmationUrl,
}: RecoveryEmailProps) => (
  <Html lang="en" dir="ltr">
    <Head />
    <Preview>Reset your password for Rollout</Preview>
    <Body style={main}>
      <Container style={container}>
        <Section style={header}>
          <Img src={logoUrl} alt="ROLLOUT" height="32" style={{ height: '32px' }} />
        </Section>
        <Section style={body}>
          <Heading style={h1}>Reset your password</Heading>
          <Text style={text}>
            We received a request to reset your password. Click below to choose a new one.
          </Text>
          <Button style={button} href={confirmationUrl}>
            Reset Password
          </Button>
          <Text style={footer}>
            If you didn't request this, you can safely ignore this email. Your password won't be changed.
          </Text>
        </Section>
      </Container>
    </Body>
  </Html>
)

export default RecoveryEmail

const logoUrl = 'https://ctnsworqzzguykzzvdme.supabase.co/storage/v1/object/public/email-assets/rollout-logo-white.png'
const main = { backgroundColor: '#ffffff', fontFamily: 'Switzer, Arial, Helvetica, sans-serif' }
const container = { maxWidth: '480px', margin: '0 auto' }
const header = { backgroundColor: '#0d0d0d', borderRadius: '12px 12px 0 0', padding: '28px 40px', textAlign: 'center' as const }
const body = { backgroundColor: '#f5f0e8', padding: '40px', borderRadius: '0 0 12px 12px' }
const h1 = { fontSize: '22px', fontWeight: 'bold' as const, color: '#0d0d0d', margin: '0 0 16px' }
const text = { fontSize: '14px', color: '#737373', lineHeight: '1.6', margin: '0 0 24px' }
const button = { backgroundColor: '#0d0d0d', color: '#f2ead9', fontSize: '14px', fontWeight: '600' as const, borderRadius: '9999px', padding: '12px 28px', textDecoration: 'none' }
const footer = { fontSize: '12px', color: '#999999', margin: '24px 0 0' }
